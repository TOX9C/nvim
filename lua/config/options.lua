
vim.opt.nu = true
vim.opt.relativenumber = true


vim.o.cursorline = true
vim.o.showmatch = true            -- Highlight matching brackets
vim.o.cmdheight = 1               -- Command line height
vim.o.splitbelow = true           -- Horizontal splits below
vim.o.splitright = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = true
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"


vim.o.ignorecase = true           -- Case-insensitive search
vim.o.smartcase = true            -- But case-sensitive if uppercase in query
vim.o.incsearch = true            -- Show matches as you type
vim.o.hlsearch = true             -- Highlight search results
vim.o.showmatch = true            -- Jump to matching bracket
vim.o.magic = true


vim.g.lazyvim_prettier_needs_config = true
vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_cmp = "blink.cmp"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

