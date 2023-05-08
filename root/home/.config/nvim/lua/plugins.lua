local packer = require('packer')

return packer.startup(function()
    use 'wbthomason/packer.nvim'
    use 'neovim/nvim-lspconfig'
    use {'ms-jpq/coq_nvim', branch = 'coq'}
    use {'ms-jpq/coq.artifacts', branch = 'artifacts'}
    use {'ms-jpq/coq.thirdparty', branch = '3p' }
    use {'ellisonleao/glow.nvim', config = function() require("glow").setup()  end}
    use {"NvChad/nvim-colorizer.lua", config = function() require("colorizer").setup() end}
    use {'sunjon/shade.nvim', config = function () require('shade').setup() end }
    use 'winston0410/cmd-parser.nvim'
    use {'winston0410/range-highlight.nvim', config = function() require('range-highlight').setup()  end }
    use "ellisonleao/gruvbox.nvim" 
    use "arcticicestudio/nord-vim"
    use "nvim-treesitter/nvim-treesitter"
    use "elkowar/yuck.vim"
    use "NoahTheDuke/vim-just"
    use "ryanoasis/vim-devicons"
    use "scrooloose/nerdtree"
    use "preservim/nerdcommenter"
    use "mhinz/vim-startify"
end)
