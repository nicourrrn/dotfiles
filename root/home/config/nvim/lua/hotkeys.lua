function map(mode, hotkey, command, additional_options)
    local options = { noremap = true } 
    if additional_options then
        options = vim.tbl_extend("force", options, additonal_options)
    end
    vim.api.nvim_set_keymap(mode, hotkey, command, options) 
end


vim.g.mapleader = ' '

map('n', '<leader>w', ':w<CR>')
map('n', '<leader>qq', ':wq!<CR>')

map('n', '<A-h>', "<C-W>H")
map('n', '<A-j>', "<C-W>J")
map('n', '<A-k>', "<C-W>K")
map('n', '<A-l>', "<C-W>L")

map('n', '<leader>n', ':NERDTreeFocus<CR>')
map('n', '<C-n>', ':NERDTreeToggle<CR>')

map('n', '<leader>ju', ':!just <CR>')


