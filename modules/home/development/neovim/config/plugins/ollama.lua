require('ollama').setup({
  model = "qwen2.5-coder:7b",
  url   = "http://127.0.0.1:11434",
  serve = {
    on_start = false,
  },
    codegen = {
      prompt = [[
You are an AI pair‑programmer. Given the context below, generate ONLY code (and inline comments if needed).
Respond in exactly THIS FORMAT: 
```$ftype
<your code>
```

File type: $ftype

--- File context ---
$buf

--- User’s instruction ---
$input
]],
      model  = "qwen2.5-coder:7b",
      action = "insert",
    },
    codereplace = {
      prompt = [[
You are an AI pair‑programmer. Given the context below, generate **only** the replacement code (and inline comments if needed).
Respond in exactly THIS FORMAT: 
```$ftype
<your code>
```

File type: $ftype

--- File context ---
$buf

--- Code to replace ---
$sel

--- User’s instruction ---
$input
]],
      model  = "qwen2.5-coder:7b",
      action = "replace",
    },
    ask = {
      prompt = [[$input]],
      model  = "qwen2.5-coder:7b",
      action = "display",
    }
  },
})

vim.keymap.set(
  { 'n', 'v' },
  '<leader>aia',
  function()
    require('ollama').prompt()
  end,
  { desc = "AI Ask (Qwen)" }
)
vim.keymap.set(
  { 'n', 'v' },
  '<leader>aig',
  function()
    require('ollama').prompt("codegen")
  end,
  { desc = "AI Codegen (Qwen)" }
)
vim.keymap.set(
  { 'n', 'v' },
  '<leader>air',
  function()
    require('ollama').prompt("codereplace")
  end,
  { desc = "AI Replace (Qwen)" }
)
