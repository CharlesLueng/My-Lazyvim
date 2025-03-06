-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local vscode = require "vscode"
local map = vim.keymap.set


vim.keymap.set("i", "jk", "<ESC>", { silent = true })


if vim.g.vscode then
  map("n", "<leader>ff", "<Cmd>lua require('vscode').call('workbench.action.quickOpen')<CR>", { desc = "Go to File" })
  map("n", "<leader>fb",
    function()
      vscode.action("workbench.action.quickOpen", {
        args = {
          "edt ",
        },
      })
    end,
    -- "<Cmd>lua require('vscode').call('workbench.action.quickOpen', {args = {prefix='edt'}})<CR>",
    { desc = "Go to Opened File" })

  map("n", "<leader>fo", function()
    vscode.action "workbench.action.files.openFolder"
  end, { desc = "" })
  map("n", "<leader>fp", function()
    vscode.action "projectManager.listProjects"
  end, { desc = "find project" })
  map("n", "<leader>fP", function()
    vscode.action "projectManager.listProjectsNewWindow"
  end)


  map("n", "zz", function()
    vscode.action "editor.toggleFold"
  end)
  map("n", "zr", function()
    vscode.action "editor.foldAll"
  end)
  map("n", "zo", function()
    vscode.action "editor.unfoldAll"
  end)


  -- buffer
  map("n", "<leader><tab><tab>", function()
    vscode.action "workbench.action.files.newUntitledFile"
    -- vscode.action j
  end)

  map("n", "<leader><tab>h", function()
    vscode.action "workbench.action.previousEditorInGroup"
  end)

  map("n", "<leader><tab>l", function()
    vscode.action "workbench.action.nextEditorInGroup"
  end)

  map("n", "<leader><tab>o", function()
    vscode.action "workbench.action.closeOtherEditors"
  end)

  map("n", "<leader>x", function()
    vscode.action "workbench.action.closeActiveEditor"
  end)

  map("n", "<leader>bc", function()
    vscode.action "workbench.action.closeActiveEditor"
  end)

  map("n", "<leader>bo", function()
    vscode.action "workbench.action.closeOtherEditors"
  end)

  -- lsp
  map("n", "<leader>cf", "<Cmd>lua require('vscode').call('editor.action.formatDocument')<CR>", { desc = "Format" })
  map("v", "<leader>cf", "<Cmd>lua require('vscode').call('editor.action.formatSelection')<CR>", { desc = "Format" })
  -- map('n', "<leader>cs", "<Cmd>lua require('vscode').call('editor.action.accessibleViewGoToSymbol')<CR>",
  --   { desc = "Go To Symbol" })
  map('n', "<leader>cs",
    function()
      vscode.action("workbench.action.quickOpen", {
        args = {
          "@ ",
        },
      })
    end,
    { desc = "Go To Symbol" })
  map("n", "<leader>cr", function()
    vscode.action "editor.action.rename"
  end, { desc = "rename" })
  map("n", "<leader>ca", function()
    vscode.action "editor.action.quickFix"
  end, { desc = "code action" })
  map("n", "K", function()
    vscode.action "editor.action.showDefinitionPreviewHover"
  end, { desc = "show definition" })
  map("n", "<leader>cd", function()
    vscode.action "workbench.panel.markers.view.focus"
  end)
  map("n", "gpd", function()
    vscode.action "editor.action.peekDefinition"
  end)
  map("n", "gh", function()
    vscode.action "editor.action.showDefinitionPreviewHover"
  end)
  map("n", "gi", function()
    vscode.action "editor.action.goToImplementation"
  end)
  map("n", "gpi", function()
    vscode.action "editor.action.peekImplementation"
  end)
  map("n", "gq", function()
    vscode.action "editor.action.quickFix"
  end)
  map("n", "gr", function()
    vscode.action "editor.action.referenceSearch.trigger"
  end)
  map("n", "gt", function()
    vscode.action "editor.action.goToTypeDefinition"
  end)
  map("n", "gpt", function()
    vscode.action "editor.action.peekTypeDefinition"
  end)


  -- zen mode
  map("n", "<leader>zz", function()
    vscode.action "workbench.action.toggleZenMode"
  end)

  -- general keymaps
  map({ "n", "v" }, "<leader>bb", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
  -- map({"n", "v"}, "<leader>d", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
  -- map({"n", "v"}, "<leader>a", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
  map({ "n", "v" }, "<leader>sp", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
  map({ "n", "v" }, "<leader>cn", "<cmd>lua require('vscode').action('notifications.clearAll')<CR>")

  -- harpoon keymaps
  map({ "n", "v" }, "<leader>ha", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>")
  map({ "n", "v" }, "<leader>ho", "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>")
  map({ "n", "v" }, "<leader>he", "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>")
  map({ "n", "v" }, "<leader>h1", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor1')<CR>")
  map({ "n", "v" }, "<leader>h2", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor2')<CR>")
  map({ "n", "v" }, "<leader>h3", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor3')<CR>")
  map({ "n", "v" }, "<leader>h4", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor4')<CR>")
  map({ "n", "v" }, "<leader>h5", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor5')<CR>")
  map({ "n", "v" }, "<leader>h6", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor6')<CR>")
  map({ "n", "v" }, "<leader>h7", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor7')<CR>")
  map({ "n", "v" }, "<leader>h8", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor8')<CR>")
  map({ "n", "v" }, "<leader>h9", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor9')<CR>")

  -- project manager keymaps
  map({ "n", "v" }, "<leader>pa", "<cmd>lua require('vscode').action('projectManager.saveProject')<CR>")
  map({ "n", "v" }, "<leader>po", "<cmd>lua require('vscode').action('projectManager.listProjectsNewWindow')<CR>")
  map({ "n", "v" }, "<leader>pe", "<cmd>lua require('vscode').action('projectManager.editProjects')<CR>")

  -- vscode
  map("n", "<leader>vo", function()
    vscode.action "workbench.action.files.openFile"
  end)
  map("n", "<leader>vf", function()
    vscode.action "workbench.action.files.openFolder"
  end)
  map("n", "<leader>vN", function()
    vscode.action "workbench.action.newWindow"
  end)
  map("n", "<leader>vc", function()
    vscode.action "workbench.action.closeWindow"
  end)
  map("n", "<leader>vs", function()
    vscode.action "workbench.action.files.save"
  end)
  map("n", "<leader>vS", function()
    vscode.action "workbench.action.files.saveAll"
  end)
  map("n", "<leader>vt", function()
    vscode.action "todo-tree-view.focus"
  end)
  map("n", "<leader>vT", function()
    vscode.action "workbench.view.extension.test"
  end)
  map("n", "<leader>vE", function()
    vscode.action "workbench.view.extensions"
  end)
  map("n", "<leader>vF", function()
    vscode.action "workbench.action.replaceInFiles"
  end)
  map("n", "<leader>vG", function()
    vscode.action "workbench.view.scm"
  end)
  map("n", "<leader>vR", function()
    vscode.action "workbench.action.tasks.restartTask"
  end)
  map("n", "<leader>vD", function()
    vscode.action "workbench.view.debug"
  end)
  map("n", "<leader>vB", function()
    vscode.action "workbench.view.extension.bookmarks"
  end)
end
