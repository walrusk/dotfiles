vim.g.mapleader = ","
vim.g.maplocalleader = ","

local opt = vim.opt

opt.autoread = true
opt.backup = false
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.expandtab = true
opt.hidden = true
opt.ignorecase = true
opt.incsearch = true
opt.laststatus = 2
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.scrolloff = 6
opt.shiftwidth = 2
opt.signcolumn = "yes"
opt.smartcase = true
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 2
opt.termguicolors = true
opt.undofile = true
opt.updatetime = 250
opt.wildignore:append({ "*/.git/*", "*/node_modules/*", "*/dist/*", "*/build/*" })

if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --hidden --glob '!.git/*'"
  opt.grepformat = "%f:%l:%c:%m"
end

local map = vim.keymap.set

map("n", "<leader>w", "<cmd>write<cr>", { desc = "Write file" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "<leader>e", "<cmd>Explore<cr>", { desc = "Open netrw" })
map("n", "<leader>t", "<cmd>terminal<cr>", { desc = "Open terminal" })
map("n", "n", "nzzzv", { desc = "Next search result" })
map("n", "N", "Nzzzv", { desc = "Previous search result" })

map("n", "<leader>f", function()
  if vim.fn.executable("rg") ~= 1 then
    vim.notify("ripgrep is not installed", vim.log.levels.WARN)
    return
  end

  local query = vim.fn.input("rg: ")
  if query == "" then
    return
  end

  vim.cmd("silent grep! " .. vim.fn.shellescape(query))
  vim.cmd("copen")
end, { desc = "Search project with ripgrep" })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local buffer = event.buf
    local opts = { buffer = buffer }

    map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Find references" }))
    map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
    map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
    map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
  end,
})

vim.diagnostic.config({
  severity_sort = true,
  virtual_text = {
    spacing = 2,
    source = "if_many",
  },
})
