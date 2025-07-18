require('ollama').setup({
  model = "qwen2.5-coder:14b",
  url   = "http://127.0.0.1:11434",
  serve = {
    on_start = false,
  },
  prompts = {
    Code_Generate_Context = {
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
      action = "insert",
    },
    Code_Replace_Context = {
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
      action = "replace",
    },
  },
})

vim.keymap.set(
  { 'n', 'v' },
  '<leader>as',
  function()
    require('ollama').prompt("Simplify_Code")
  end,
  { desc = "AI Simplify Code (with file context)" }
)
vim.keymap.set(
  { 'n', 'v' },
  '<leader>aa',
  function()
    require('ollama').prompt()
  end,
  { desc = "AI Ask" }
)
vim.keymap.set(
  { 'n', 'v' },
  '<leader>ag',
  function()
    require('ollama').prompt("Generate_Code_Context")
  end,
  { desc = "AI Generate Code (with file context)" }
)
vim.keymap.set(
  { 'n', 'v' },
  '<leader>ar',
  function()
    require('ollama').prompt("Replace_Code_Context")
  end,
  { desc = "AI Replace Code (with file context)" }
)
