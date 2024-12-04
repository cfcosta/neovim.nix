local Utils = require("avante.utils")
local Config = require("avante.config")
local Clipboard = require("avante.clipboard")
local P = require("avante.providers")

require("avante_lib").load()

local parse_message = function(opts)
  local user_content = {}
  if Config.behaviour.support_paste_from_clipboard and opts.image_paths and #opts.image_paths > 0 then
    for _, image_path in ipairs(opts.image_paths) do
      table.insert(user_content, {
        type = "image_url",
        image_url = {
          url = "data:image/png;base64," .. Clipboard.get_base64_content(image_path),
        },
      })
    end
    vim.iter(opts.user_prompts):each(function(prompt)
      table.insert(user_content, { type = "text", text = prompt })
    end)
  else
    user_content = vim.iter(opts.user_prompts):fold({}, function(acc, prompt)
      table.insert(acc, { type = "text", text = prompt })
      return acc
    end)
  end

  return {
    { role = "system", content = opts.system_prompt },
    { role = "user",   content = user_content },
  }
end

require("avante").setup({
  provider = os.getenv("AVANTE_PROVIDER") or "claude",

  dual_boost = {
    enabled = false,
    first_provider = "claude",
    second_provider = "openrouter",
    prompt =
    "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
    timeout = 60000, -- Timeout in milliseconds
  },

  claude = {
    model = os.getenv("AVANTE_CLAUDE_MODEL") or "claude-3-5-sonnet-latest",
  },
  openai = {
    model = os.getenv("AVANTE_OPENAI_MODEL") or "gpt4o-mini",
  },
  behaviour = {
    auto_suggestions = false,
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
    minimize_diff = true,
  },

  mappings = {
    suggestion = {
      accept = "<Tab>",
    },
  },

  vendors = {
    ["openrouter"] = {
      endpoint = "https://openrouter.ai/api/v1",
      model = os.getenv("AVANTE_OPENROUTER_MODEL") or "qwen/qwq-32b-preview",
      api_key_name = "OPENROUTER_API_KEY",
      parse_curl_args = function(provider, code_opts)
        local base, body_opts = P.parse_config(provider)

        local headers = {
          ["Content-Type"] = "application/json",
        }
        if not P.env.is_local("openai") then
          headers["Authorization"] = "Bearer " .. provider.parse_api_key()
        end

        return {
          url = Utils.trim(base.endpoint, { suffix = "/" }) .. "/chat/completions",
          proxy = base.proxy,
          insecure = base.allow_insecure,
          headers = headers,
          body = vim.tbl_deep_extend("force", {
            model = base.model,
            messages = parse_message(code_opts),
            stream = true,
          }, body_opts),
        }
      end,
      parse_response_data = function(data_stream, _, opts)
        if data_stream:match('"%[DONE%]":') then
          opts.on_complete(nil)
          return
        end
        if data_stream:match('"delta":') then
          local json = vim.json.decode(data_stream)
          if json.choices and json.choices[1] then
            local choice = json.choices[1]
            if choice.finish_reason == "stop" then
              opts.on_complete(nil)
            elseif choice.delta.content then
              if choice.delta.content ~= vim.NIL then
                opts.on_chunk(choice.delta.content)
              end
            end
          end
        end
      end,
    },
  },
})
