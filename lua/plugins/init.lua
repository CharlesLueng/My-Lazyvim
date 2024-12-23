return {
  -- {
  --   "navarasu/onedark.nvim",
  --   config = function()
  --     require("onedark").setup({
  --       style = "dark",
  --     })
  --     require("onedark").load()
  --   end,
  -- },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require("onedarkpro").setup(opts)
      require("onedarkpro").load()

      -- vim.cmd("colorschema onedark")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        omnisharp = {
          cmd = { "dotnet", "/home/charles/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },
        },
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    keys = function()
      local keys = {
        {
          "<leader>ha",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon File",
        },
        {
          "<leader>he",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
        {
          "<leader>h",
          desc = "Harpoon",
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "<leader>h" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
    end,
  },
  {
    "danymat/neogen",
    opts = {
      languages = {
        cs = {
          template = {
            annotation_convention = "xmldoc",
          },
        },
      },
    },
  },
  {
    "max397574/better-escape.nvim",
    opts = {},
  },
  -- {
  --   "mfussenegger/nvim-dap",
  --   optional = true,
  --   opts = function()
  --     local dap = require("dap")
  --     if not dap.adapters["netcoredbg"] then
  --       require("dap").adapters["netcoredbg"] = {
  --         type = "executable",
  --         command = vim.fn.exepath("netcoredbg"),
  --         args = { "--interpreter=vscode" },
  --         options = {
  --           detached = false,
  --         },
  --       }
  --     end
  --     for _, lang in ipairs({ "cs", "fsharp", "vb" }) do
  --       if not dap.configurations[lang] then
  --         dap.configurations[lang] = {
  --           {
  --             type = "netcoredbg",
  --             name = "Launch file",
  --             request = "launch",
  --             ---@diagnostic disable-next-line: redundant-parameter
  --             program = function()
  --               return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
  --             end,
  --             cwd = "${workspaceFolder}",
  --           },
  --           {
  --             type = "netcoredbg",
  --             name = "Launch - netcoredbg",
  --             request = "attach",
  --             pid = function()
  --               local pgrep = vim.fn.system("pgrep -f 'dotnet run --project Beehive'")
  --               return tonumber(pgrep)
  --             end,
  --             preLaunchTask = function()
  --               Term = vim.fn.termopen("dotnet run --project Beehive")
  --             end,
  --           },
  --         }
  --       end
  --     end
  --   end,
  -- },
}
