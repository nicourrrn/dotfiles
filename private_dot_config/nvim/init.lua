-- Base settings
vim.g.mapleader = " " -- Set leader key to space

-- Clipboard: use system clipboard (requires wl-copy/wl-paste on Wayland)
vim.opt.clipboard = "unnamedplus"

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs and indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- UI settings
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8 -- Keep context when scrolling

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable mouse support
vim.opt.mouse = "a"

-- Basic keymaps
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlight" })
