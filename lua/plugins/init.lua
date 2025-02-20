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
    opts = {
      colors = {
        onedark = { bg = "#262626" },
      },
      options = {
        transparency = true,
      },
    },
    config = function(_, opts)
      require("onedarkpro").setup(opts)
      require("onedarkpro").load()

      -- vim.cmd("colorschema onedark")
    end,
  },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   opts = {},
  --   config = function()
  --     local lspconfig = require('lspconfig')
  --     require("mason-lspconfig").setup_handlers({
  --       function(server_name)
  --         print(server_name)
  --         print(require("neoconf").get(server_name .. ".disable"))
  --         -- local server_config = {}
  --         if require("neoconf").get(server_name .. ".disable") then
  --           return
  --         end
  --         -- if server_name == "volar" then
  --         --   server_config.filetypes = { "vue", "typescript", "javascript" }
  --         -- end
  --         -- lspconfig[server_name].setup(server_config)
  --       end,
  --     })
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      ---@type vim.diagnostic.Opts
      diagnostics = {
        virtual_text = false,
      },
      ---type lspconfig.options
      servers = {
        omnisharp = false,
        -- omnisharp = {
        --   cmd = { "dotnet", "/home/charles/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },
        --   settings = {
        --     FormattingOptions = {
        --       -- Enables support for reading code style, naming convention and analyzer
        --       -- settings from .editorconfig.
        --       EnableEditorConfigSupport = false,
        --       -- Specifies whether 'using' directives should be grouped and sorted during
        --       -- document formatting.
        --       OrganizeImports = nil,
        --     },
        --     MsBuild = {
        --       -- If true, MSBuild project system will only load projects for files that
        --       -- were opened in the editor. This setting is useful for big C# codebases
        --       -- and allows for faster initialization of code navigation features only
        --       -- for projects that are relevant to code that is being edited. With this
        --       -- setting enabled OmniSharp may load fewer projects and may thus display
        --       -- incomplete reference lists for symbols.
        --       -- LoadProjectsOnDemand = nil,
        --       LoadProjectsOnDemand = true,
        --     },
        --     RoslynExtensionsOptions = {
        --       -- Enables support for roslyn analyzers, code fixes and rulesets.
        --       EnableAnalyzersSupport = nil,
        --       -- Enables support for showing unimported types and unimported extension
        --       -- methods in completion lists. When committed, the appropriate using
        --       -- directive will be added at the top of the current file. This option can
        --       -- have a negative impact on initial completion responsiveness,
        --       -- particularly for the first few completion sessions after opening a
        --       -- solution.
        --       EnableImportCompletion = nil,
        --       -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
        --       -- true
        --       -- AnalyzeOpenDocumentsOnly = nil,
        --       AnalyzeOpenDocumentsOnly = true,
        --     },
        --     Sdk = {
        --       -- Specifies whether to include preview versions of the .NET SDK when
        --       -- determining which version to use for project loading.
        --       IncludePrereleases = true,
        --     },
        --   },
        -- },
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
  -- {
  --   "max397574/better-escape.nvim",
  --   opts = {
  --     mappings = {
  --       i = {
  --         j = {
  --           k = function()
  --             if vim.bo.filetype == "yazi" then
  --               -- Type 'jk' normally when inside filetype 'Yourfiletype'
  --               -- <c-v> is used to avoid mappings
  --               return "<c-v>j<c-v>k"
  --             end
  --             return "<esc>"
  --           end,
  --         },
  --       },
  --     },
  --   },
  -- },
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- load mason-nvim-dap here, after all adapters have been setup
      if LazyVim.has("mason-nvim-dap.nvim") then
        require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
      end

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(LazyVim.config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      -- setup dap config by VsCode launch.json file
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end

      local dap = require("dap")

      dap.configurations.cs = {
        -- {
        --     type = 'coreclr',
        --     name = 'launch - netcoredbg',
        --     request = 'launch',
        --     program = function()
        --         return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        --     end,
        -- },
        {
          type = "netcoredbg",
          name = "Launch file",
          request = "launch",
          ---@diagnostic disable-next-line: redundant-parameter
          program = function()
            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
        },
        {
          type = "netcoredbg",
          name = "Attach",
          request = "attach",
          processId = function()
            local pgrep = vim.fn.input("Pid: ")
            return tonumber(pgrep)
          end,
          cwd = "${workspaceFolder}",
        },
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:crashdummyy/mason-registry",
      },
    },
  },
  {
    "seblj/roslyn.nvim",
    -- ft = { "cs", "cshtml", "html" },
    dependencies = {
      {
        "tris203/rzls.nvim",
        config = function()
          local capabilities = require("blink.cmp").get_lsp_capabilities(nil, true)
          require("rzls").setup({
            on_attach = function() end,
            capabilities = capabilities,
          })
        end,
      },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities(nil, true)
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      -- capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
      -- capabilities = vim.tbl_deep_extend("force", capabilities, {
      --   textDocument = {
      --     diagnostic = {
      --       dynamicRegistration = true,
      --     },
      --   },
      -- })
      require("roslyn").setup({
        --- @type InternalRoslynNvimConfig
        filewatching = false,
        -- args = {
        --   "--logLevel=Information",
        --   "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
        --   "--razorSourceGenerator=" .. vim.fs.joinpath(
        --     vim.fn.stdpath("data") --[[@as string]],
        --     "mason",
        --     "packages",
        --     "roslyn",
        --     "libexec",
        --     "Microsoft.CodeAnalysis.Razor.Compiler.dll"
        --   ),
        --   "--razorDesignTimePath=" .. vim.fs.joinpath(
        --     vim.fn.stdpath("data") --[[@as string]],
        --     "mason",
        --     "packages",
        --     "rzls",
        --     "libexec",
        --     "Targets",
        --     "Microsoft.NET.Sdk.Razor.DesignTime.targets"
        --   ),
        -- },
        config = {
          cmd = {},
          -- on_attach = require("lspattach"),
          capabilities = capabilities,
          -- handlers = require("rzls.roslyn_handlers"),
          settings = {
            ["csharp|inlay_hints"] = {
              csharp_enable_inlay_hints_for_implicit_object_creation = true,
              csharp_enable_inlay_hints_for_implicit_variable_types = false,

              -- csharp_enable_inlay_hints_for_lambda_parameter_types = false,
              -- csharp_enable_inlay_hints_for_types = true,
              -- dotnet_enable_inlay_hints_for_indexer_parameters = true,
              -- dotnet_enable_inlay_hints_for_literal_parameters = true,
              -- dotnet_enable_inlay_hints_for_object_creation_parameters = true,
              -- dotnet_enable_inlay_hints_for_other_parameters = true,
              -- dotnet_enable_inlay_hints_for_parameters = true,
              dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
            },
            ["csharp|code_lens"] = {
              dotnet_enable_references_code_lens = true,
            },
            ["csharp|background_analysis"] = {
              dotnet_analyzer_diagnostics_scope = "openFiles",
              dotnet_compiler_diagnostics_scope = "fullSolution",
            },
          },

          -- capabilities = capabilities,
          -- handlers = require("rzls.roslyn_handlers"),
          -- settings = {
          --   ["csharp|background_analysis"] = {
          --     -- background_analysis = {
          --     --     dotnet_analyzer_diagnostics_scope = "openFiles",
          --     --     dotnet_compiler_diagnostics_scope = "fullSolution",
          --     -- },
          --     dotnet_analyzer_diagnostics_scope = "fullSolution",
          --     dotnet_compiler_diagnostics_scope = "fullSolution",
          --   },
          --   ["csharp|inlay_hints"] = {
          --     csharp_enable_inlay_hints_for_implicit_object_creation = true,
          --     csharp_enable_inlay_hints_for_implicit_variable_types = true,
          --     csharp_enable_inlay_hints_for_lambda_parameter_types = true,
          --     csharp_enable_inlay_hints_for_types = true,
          --     dotnet_enable_inlay_hints_for_indexer_parameters = true,
          --     dotnet_enable_inlay_hints_for_literal_parameters = true,
          --     dotnet_enable_inlay_hints_for_object_creation_parameters = true,
          --     dotnet_enable_inlay_hints_for_other_parameters = true,
          --     dotnet_enable_inlay_hints_for_parameters = true,
          --     dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
          --     dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
          --     dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          --   },
          -- },
        },
      })
    end,
  },
  {
    "andrewferrier/wrapping.nvim",
    opts = {
      set_nvim_opt_defaults = false,
    },
    config = function(_, opts)
      require("wrapping").setup(opts)
      require("wrapping").soft_wrap_mode()
    end,
    -- config = function()
    --     require("wrapping").setup()
    -- end
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
        python = { "isort", "black" },
      },
      formatters = {
        csharpier = {
          command = "dotnet-csharpier",
          args = { "--write-stdout" },
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = {
        'Kaiser-Yang/blink-cmp-avante',
        -- ... Other dependencies
    },
    opts = {
        sources = {
            -- Add 'avante' to the list
            default = { 'avante', 'lsp', 'path', 'snippets', 'buffer' },
            providers = {
                avante = {
                    module = 'blink-cmp-avante',
                    name = 'Avante',
                    opts = {
                        -- options for blink-cmp-avante
                    }
                }
            },
        }
    }
  },
  -- {
  --   "saghen/blink.compat",
  --   optional = false, -- make optional so it's only enabled if any extras need it
  --   opts = {},
  --   version = not vim.g.lazyvim_blink_main and "*",
  -- },
  -- {
  --   "saghen/blink.cmp",
  --   opts = {
  --     sources = {
  --       compat = {
  --         "avante_commands",
  --         "avante_mentions",
  --         "avante_files",
  --       },
  --       providers = {
  --         avante_commands = {
  --           name = "avante_commands",
  --           module = "blink.compat.source",
  --           score_offset = 90, -- show at a higher priority than lsp
  --           opts = {},
  --         },
  --         avante_files = {
  --           name = "avante_commands",
  --           module = "blink.compat.source",
  --           score_offset = 100, -- show at a higher priority than lsp
  --           opts = {},
  --         },
  --         avante_mentions = {
  --           name = "avante_mentions",
  --           module = "blink.compat.source",
  --           score_offset = 1000, -- show at a higher priority than lsp
  --           opts = {},
  --         },
  --       },
  --     },
  --   },
  -- },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
}
