-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.opt.splitkeep = "screen"

local Utils = require("avante.utils")
local Config = require("avante.config")
local Clipboard = require("avante.clipboard")
local P = require("avante.providers")

require("avante_lib").load()

local parse_message = function(opts)
  ---@type OpenAIMessage[]
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
    { role = "user", content = user_content },
  }
end

require("avante").setup({
  provider = os.getenv("AVANTE_PROVIDER") or "claude",
  auto_suggestion_provider = os.getenv("AVANTE_AUTO_SUGGESTION_PROVIDER") or "openai",

  claude = {
    model = os.getenv("AVANTE_CLAUDE_MODEL") or "claude-3-5-sonnet-20240620",
  },
  openai = {
    model = os.getenv("AVANTE_OPENAI_MODEL") or "gpt4o-mini",
  },

  vendors = {
    ["openrouter"] = {
      endpoint = "https://openrouter.ai/api/v1",
      model = os.getenv("AVANTE_OPENROUTER_MODEL") or "openai/o1-mini",
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
          ---@type OpenAIChatResponse
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
