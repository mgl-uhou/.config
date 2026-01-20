return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- Carrega o plugin apenas quando necessário ou inicia com o Neovim
    event = { "InsertLeave", "TextChanged" }, -- Eventos que ativam o plugin
    config = function()
      require("auto-save").setup({
        enabled = true, -- Inicia ativado
        trigger_events = { -- Eventos que disparam o salvamento
          immediate_save = { "BufLeave", "FocusLost" }, -- Salva ao trocar de buffer/janela
          defer_save = { "InsertLeave", "TextChanged" }, -- Salva ao parar de digitar
        },
        debounce_delay = 1000, -- Espera 1 segundo (1000ms) antes de salvar (bom para seu HD externo)
      })
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- carrega os mapeamentos padrão
        api.config.mappings.default_on_attach(bufnr)

        -- mapeamentos personalizados
        vim.keymap.set("n", "d", api.fs.trash, opts "Trash")
        vim.keymap.set("n", "D", api.fs.remove, opts "Delete")
      end,
    },
  },
}
