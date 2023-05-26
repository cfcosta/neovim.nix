return function()
  if os.getenv "OPENAI_API_KEY" then
    require "codegpt.config"
  end
end
