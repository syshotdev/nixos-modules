local map = vim.keymap.set
local which_key = require('which-key')

local function map_category_description(key, description)
  vim.keymap.set('n', key, '<nop>', { desc = description })
end

-- Single quotes and parentheses are now required
map_category_description('<leader>f', 'Find')
-- which_key.add({{'<leader>f', group = 'Find'}})
-- Register group descriptions using which-key.add() with a keyed table.
which_key.add({
  ["<leader>f"] = { group = "Find" },
  ["<leader>w"] = { group = "Window" },
  ["<leader>t"] = { group = "Tab" },
  ["<leader>l"] = { group = "Language/Text" },
})
map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', { desc = 'Find Files', noremap = true })
map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', { desc = 'Find Words', noremap = true })
map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', { desc = 'Find Buffers', noremap = true })

-- Toggle Spectre for mass finding and renaming of words
map('n', '<leader>fr', '<cmd>lua require("spectre").toggle()<cr>',
  { desc = 'Find And Replace (With Spectre)', noremap = true })

map_category_description('<leader>t', 'File (T)ree')
-- File(TreeToggle)
map('n', '<leader>tt', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle File Tree', noremap = true })

-- <C-\> for terminal

map_category_description('<leader>w', 'Window')
-- Splits
map('n', '<leader>wh', '<cmd>split<cr>', { desc = 'Window Horizontal Split', noremap = true })
map('n', '<leader>wv', '<cmd>vsplit<cr>', { desc = 'Window Vertical Split', noremap = true })

-- Navigate between splits
map('n', '<C-h>', '<cmd>wincmd h<cr>', { desc = 'Move To Split Left', noremap = true })
map('n', '<C-l>', '<cmd>wincmd l<cr>', { desc = 'Move To Split Right', noremap = true })
map('n', '<C-k>', '<cmd>wincmd k<cr>', { desc = 'Move To Split Up', noremap = true })
map('n', '<C-j>', '<cmd>wincmd j<cr>', { desc = 'Move To Split Down', noremap = true })

-- Resize splits
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Resize Left', noremap = true })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Resize Right', noremap = true })
map('n', '<C-Up>', '<cmd>resize -2<cr>', { desc = 'Resize Up', noremap = true })
map('n', '<C-Down>', '<cmd>resize +2<cr>', { desc = 'Resize Down', noremap = true })

map_category_description('<leader>t', 'Tab')
-- Tabs (I think they're like workspaces?)
map('n', '<leader>tn', '<cmd>tabnew<cr>', { desc = 'Tab New', noremap = true })
map('n', '<leader>tc', '<cmd>tabclose<cr>', { desc = 'Tab Close', noremap = true })
-- Alt for easier access between them
map('n', '<A-h>', '<cmd>tabprevious<cr>', { desc = 'Tab Previous', noremap = true })
map('n', '<A-l>', '<cmd>tabnext<cr>', { desc = 'Tab Next', noremap = true })

map_category_description('<leader>l', 'Language/Text')
map('n', '<leader>lm', '<cmd>lua require("render-markdown").toggle()<cr>', { desc = 'Markdown Toggle', noremap = true })
map('n', '<leader>la', '<cmd>set spell!<cr>', { desc = 'Autocorrect Toggle', noremap = true })
map('n', '<leader>lc', 'z=', { desc = 'Correct Hovered Word', noremap = true })



-- Force remove split
map('n', '<C-q>', function()
  if vim.bo.modifiable and not vim.bo.readonly then
    vim.cmd('wq')
  else
    vim.cmd('q!')
  end
end, { desc = 'Force Close Split', noremap = true })

map_category_description('<leader>g', 'Goto')
-- Key mappings for LSP
-- All of these do basically the same thing
map('n', '<leader>gd', vim.lsp.buf.definition, { desc = 'Goto Definition', noremap = true })
map('n', '<leader>gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration', noremap = true })
map('n', '<leader>gi', vim.lsp.buf.implementation, { desc = 'Goto Implementation', noremap = true })

-- Where has this thing been used
map('n', '<leader>gr', vim.lsp.buf.references, { desc = 'Goto References', noremap = true })

map_category_description('<leader>c', 'Code')
-- c(code) a(action)
map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action', noremap = true })
map('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Code Rename', noremap = true })
map('n', '<leader>cf', function()
  vim.lsp.buf.format { async = true }
end, { desc = 'Code Format', noremap = true })
-- This 'Code Sort' doesn't work for whatever reason, use :sort
--map('v', '<leader>cs', '<cmd>'<,'>sort<cr>', { desc = 'Code Sort', noremap = true })

map("n", "<leader>dt", ":lua require('dapui').toggle()<CR>", { desc = 'Debugger Toggle', noremap = true })
map("n", "<leader>dr", ":lua require('dap').continue()<CR>", { desc = 'Debugger Run', noremap = true })

map("n", "<F1>", ":lua require('dap').step_over()<CR>", { desc = 'Step Over', noremap = true })
map("n", "<F2>", ":lua require('dap').step_into()<CR>", { desc = 'Step Into', noremap = true })
map("n", "<F3>", ":lua require('dap').step_out()<CR>", { desc = 'Step Out Of', noremap = true })

map("n", "<Leader>dh", ":lua require('dap.ui.variables').hover()<CR>", { desc = 'Debugger Hover', noremap = true })
map("v", "<Leader>dh", ":lua require('dap.ui.variables').visual_hover()<CR>", { desc = 'Debugger Visual Hover', noremap = true })

map("n", "<Leader>dro", ":lua require('dap').repl.open()<CR>", { desc = 'Debugger Repl Open', noremap = true })
map("n", "<Leader>drl", ":lua require('dap').repl.run_last()<CR>", { desc = 'Debugger Repl Run Last', noremap = true })

map("n", "<leader>db", ":lua require('dap').toggle_breakpoint()<CR>", { desc = 'Debugger Breakpoint', noremap = true })
map("n", "<Leader>dc", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { desc = 'Debugger Breakpoint Condition', noremap = true })
--map("n", "<Leader>dbm", ":lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') )<CR>")

map("n", "<Leader>ds", ":lua require('dap.ui.variables').scopes()<CR>", { desc = 'Debugger Scopes', noremap = true })

local function close_all_tabs_and_save()
  local tabpages = vim.api.nvim_list_tabpages()
  for _, tabpage in ipairs(tabpages) do
    local windows = vim.api.nvim_tabpage_list_wins(tabpage)
    for _, win in ipairs(windows) do
      local buf = vim.api.nvim_win_get_buf(win)
      local readonly = vim.api.nvim_buf_get_option(buf, 'readonly')
      if not readonly then
        vim.cmd('write')
      end
      vim.cmd('bdelete! ' .. buf)
    end
  end
end

-- QuitAllForce
vim.api.nvim_create_user_command('QuitAllForce', close_all_tabs_and_save, {})

--[[
-- I don't think these work/I don't need them rn:
--

map('n', '<leader>D', vim.lsp.buf.type_definition, opts)
map('n', '<leader>fh', builtin.help_tags, {})
map('n', 'K', vim.lsp.buf.hover, opts)
map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
map('n', 'wa', vim.lsp.buf.add_workspace_folder, opts)
map('n', 'wr', vim.lsp.buf.remove_workspace_folder, opts)
map('n', 'wl', function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts)
]]
--
