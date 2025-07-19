local response_format = "Respond EXACTLY in this format:\n```$ftype\n<your code>\n```"

require('ollama').setup({
  model = "qwen2.5-coder:14b",
  url   = "http://127.0.0.1:11434",
  serve = {
    on_start = false,
  },
  prompts = {
    Generate_Code_Context = {
      prompt = "You are an AI pair-programmer. Given the user's instructions and context below, generate **only** code (including inline comments if necessary) based on their directions."
              .. response_format
              .. "\n--- User's instruction ---\n$input"
              .. "\n--- File context ---\n```$ftype\n$buf\n```",
      action = "insert",
    },
    Replace_Code_Context = {
      prompt = "You are an AI pair-programmer. Given the user's instructions and context below, replace the selected code with **only** code and with the requested modifications (including inline comments if necessary)."
              .. response_format
              .. "\n--- User's instruction ---\n$input"
              .. "\n--- Selected code ---\n```$ftype\n$sel```\n"
              .. "\n--- File context ---\n```$ftype\n$buf\n```",
      action = "replace",
    },
  },
})
