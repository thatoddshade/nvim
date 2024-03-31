return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      {
        -- Optional
        "williamboman/mason.nvim",
        build = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },     -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "L3MON4D3/LuaSnip" },     -- Required
    },
    config = function()
      local lsp = require("lsp-zero").preset("recommended")

      lsp.ensure_installed({
        "rust_analyzer",
        "tsserver",
        "lua_ls",
        "gopls",
      })

      lsp.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
        vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
        vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
        vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
        vim.keymap.set("n", "lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        vim.keymap.set("n", "la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

        vim.keymap.set("n", "lw", "<cmd>Telescope diagnostics<cr>", opts)
        vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
        vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
        vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)

        -- check file type, if Go then use GoFmt else the default
        if vim.bo.filetype == "go" then
          vim.keymap.set({ "n", "x" }, "lf", "<cmd>GoFmt<cr>", opts)
        else
          vim.keymap.set({ "n", "x" }, "lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
        end
      end)

      lsp.set_preferences({
        suggest_lsp_servers = false,
        sign_icons = {
          error = "E",
          warn = "W",
          hint = "H",
          info = "I",
        },
      })

      -- require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      })

      lsp.setup()

      local cmp = require("cmp")
      local cmp_action = require("lsp-zero").cmp_action()

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = {
          ["<Tab>"] = cmp_action.luasnip_supertab(),
          ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
        },

        sources = {
          -- Copilot Source
          { name = "copilot",  group_index = 2 },
          -- Other Sources
          { name = "nvim_lsp", group_index = 2 },
          { name = "path",     group_index = 2 },
          { name = "luasnip",  group_index = 2 },
        },
      })
    end,
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            vim.cmd.cprev()
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            vim.cmd.cnext()
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-lua/plenary.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("ui-select")
      end,
    },
    keys = {
      { "<leader>st",       "<cmd>Telescope live_grep<cr>",                 desc = "Live Grep" },
      { "<leader>:",        "<cmd>Telescope command_history<cr>",           desc = "Command History" },
      { "<leader>fb",       "<cmd>Telescope buffers<cr>",                   desc = "Buffers" },
      { "<leader><leader>", "<cmd>Telescope buffers<cr>",                   desc = "Buffers" },
      { "<leader>ff",       "<cmd>Telescope find_files<cr>",                desc = "Find Files" },
      { "<C-f>",            "<cmd>Telescope find_files<cr>",                desc = "Find Files" },
      { "<C-p>",            "<cmd>Telescope git_files<cr>",                 desc = "Git Files" },
      { "<leader>sa",       "<cmd>Telescope autocommands<cr>",              desc = "Auto Commands" },
      { "<leader>sb",       "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc",       "<cmd>Telescope command_history<cr>",           desc = "Command History" },
      { "<leader>sC",       "<cmd>Telescope commands<cr>",                  desc = "Commands" },
      { "<leader>sd",       "<cmd>Telescope diagnostics bufnr=0<cr>",       desc = "Document diagnostics" },
      { "<leader>sD",       "<cmd>Telescope diagnostics<cr>",               desc = "Workspace diagnostics" },
      { "<leader>sh",       "<cmd>Telescope help_tags<cr>",                 desc = "Help Pages" },
      { "<leader>sH",       "<cmd>Telescope highlights<cr>",                desc = "Search Highlight Groups" },
      { "<leader>sk",       "<cmd>Telescope keymaps<cr>",                   desc = "Key Maps" },
      { "<leader>sM",       "<cmd>Telescope man_pages<cr>",                 desc = "Man Pages" },
      { "<leader>sm",       "<cmd>Telescope marks<cr>",                     desc = "Jump to Mark" },
      { "<leader>so",       "<cmd>Telescope vim_options<cr>",               desc = "Options" },
      { "<leader>sR",       "<cmd>Telescope resume<cr>",                    desc = "Resume" },
      { "<leader>sw",       "<cmd>Telescope grep_string<cr>",               desc = "Grep String" },
    },
    opts = {
      defaults = {
        previewer = false,
        hidden = true,
        file_ignore_patterns = { "node_modules", "package-lock.json" },
        initial_mode = "insert",
        select_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          width = 0.5,
          height = 0.4,
          prompt_position = "top",
          preview_cutoff = 120,
        },
      },
      pickers = {
        find_files = {
          previewer = false,
        },
        git_files = {
          previewer = false,
        },
        buffers = {
          previewer = false,
        },
        live_grep = {
          only_sort_text = true,
          previewer = true,
          layout_config = {
            horizontal = {
              width = 0.9,
              height = 0.75,
              preview_width = 0.6,
            },
          },
        },
        grep_string = {
          only_sort_text = true,
          previewer = true,
          layout_config = {
            horizontal = {
              width = 0.9,
              height = 0.75,
              preview_width = 0.6,
            },
          },
        },
        lsp_references = {
          show_line = false,
          previewer = true,
          layout_config = {
            horizontal = {
              width = 0.9,
              height = 0.75,
              preview_width = 0.6,
            },
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        },
        ["ui-select"] = function()
          require("telescope.themes").get_dropdown({
            previewer = false,
            initial_mode = "normal",
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
              horizontal = {
                width = 0.5,
                height = 0.4,
                preview_width = 0.6,
              },
            },
          })
        end,
      },
    },
  }

