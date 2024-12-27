-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = false

vim.g.root_spec = { "lsp", "cwd", { ".git", "lua" } }

-- Disable Auto Format
vim.g.autoformat = false

-- Terminal
if vim.loop.os_uname().sysname == "Windows_NT" then
  -- -- 命令行重置为powershell
  local powershell_options = {
    shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
    shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
  }

  for option, value in pairs(powershell_options) do
    vim.opt[option] = value
  end
  -- vim.opt.shell = "nu"

  -- local nushell_options = {
  --   shell = "nu",
  --   shellcmdflag = "--login --stdin --no-newline -c",
  --   shellredir = "out+err> %s",
  --   shellpipe = "| complete | update stderr { ansi strip } | tee { get stderr | save --force --raw %s } | into record",
  --   shelltemp = false,
  --   shellxescape = "",
  --   shellxquote = "",
  --   shellquote = "",
  -- }
  --
  -- for option, value in pairs(nushell_options) do
  --   vim.opt[option] = value
  -- end
end
