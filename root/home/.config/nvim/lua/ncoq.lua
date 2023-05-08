local lsp = require 'lspconfig'
local util = require 'lspconfig/util'

 vim.g.coq_settings = { auto_start = 'shut-up', limits = { completion_auto_timeout = 2 } }
 local coq = require 'coq'

lsp.pyright.setup(coq.lsp_ensure_capabilities({}))
lsp.gopls.setup(coq.lsp_ensure_capabilities({}))
lsp.ccls.setup(coq.lsp_ensure_capabilities({}))
lsp["rust_analyzer"].setup(coq.lsp_ensure_capabilities({}))
lsp.ruff_lsp.setup(coq.lsp_ensure_capabilities({}))
lsp.tailwindcss.setup(coq.lsp_ensure_capabilities({}))

lsp.csharp_ls.setup(coq.lsp_ensure_capabilities({}))
lsp.java_language_server.setup(coq.lsp_ensure_capabilities({
    cmd = {"/usr/share/java/java-language-server/lang_server_linux.sh"}, 
    root_dir =  util.root_pattern('gradlew', '.git', 'mvnw')
}))


require('nvim-treesitter.configs').setup({
    ensure_installed = {'c', 'python', 'go', 'php', 'c_sharp', 'rust', 'lua', 'java'},

    sync_install = false,

    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    
})

