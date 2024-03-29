local overrides = require("custom.configs.overrides")
-- local functions = require("custom.core.functions")

--@type NvPluginSpec[]
local plugins = {

	{},
  {
    "potamides/pantran.nvim",
		lazy = false,
		config = function()
			require("custom.configs.pantran")
		end,
  },

	{
		"aspeddro/pandoc.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"jbyuki/nabla.nvim", -- optional
		},
		config = function()
			require("pandoc").setup()
		end,
	},
	{
		"goolord/alpha-nvim",
		lazy = false,
		config = function()
			require("custom.configs.alpha")
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		ft = "gitcommit",
		opts = overrides.gitsigns,
	},

	{
		"akinsho/toggleterm.nvim",
		-- version = "*",
		keys = {
			{
				"<leader>Tf",
				"<leader>Tl",
				"<leader>Tr",
			},
		},
		config = function()
			require("custom.configs.toggleterm")
		end,
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ ranger
	{
		"kevinhwang91/rnvimr",
		lazy = false,
		-- keys = { "<leader>r" },
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ vim-dadbod-ui
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-completion",
			"tpope/vim-dotenv",
		},
		keys = { { "<localleader><localleader>db", ":tab DBUI<cr>" } },
		init = function()
			require("custom.configs.database")
		end,
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ Nvim-R
	{
		"jalvesaq/Nvim-R",
		ft = { "r" },
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ undotree
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		lazy = true,
		config = function()
			require("custom.configs.undotree")
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ Events and dependencies
	{
		"nvim-telescope/telescope-bibtex.nvim",
		config = function()
			require("telescope").load_extension("bibtex")
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				-- "hrsh7th/cmp-nvim-lsp",
				-- "hrsh7th/cmp-buffer",
				-- "hrsh7th/cmp-path",
				-- "saadparwaiz1/cmp_luasnip",
				"kdheepak/cmp-latex-symbols",

				"jalvesaq/cmp-nvim-r",
				-- {
				-- 	"jalvesaq/cmp-nvim-r",
				-- 	config = function()
				-- 		require("custom.configs.cmp-nvim-r")
				-- 	end,
				-- },
				-- "hrsh7th/cmp-calc",
				-- "hrsh7th/cmp-cmdline",
				-- "hrsh7th/cmp-nvim-lsp-document-symbol",
				-- "hrsh7th/cmp-nvim-lsp-signature-help",
				-- "hrsh7th/cmp-omni", -- helps Vimtex completions
				"f3fora/cmp-spell",
				"aspeddro/cmp-pandoc.nvim",
				-- "onsails/lspkind-nvim",
				-- "roobert/tailwindcss-colorizer-cmp.nvim",
			},
		},
		-- opts = overrides.cmp,

		opts = function(_, opts)
			-- local cmp_conf = require("plugins.configs.cmp")
			-- local format_kinds = opts.formatting.format
			-- opts.formatting.format = function(entry, item)
			-- 	format_kinds(entry, item)
			-- 	return overrides.cmp.formatting.format(_, item)
			-- 	-- return require("tailwindcss-colorizer-cmp").formatter(entry, item)
			-- end
			opts.formatting = overrides.cmp.formatting
			opts.sources = overrides.cmp.sources
			-- table.insert(opts.sources, { overrides.cmp.sources })
			opts.completion = {
				completeopt = "menu,menuone,noselect,noinsert",
			}
			opts.window = {
				documentation = overrides.cmp.window.documentation,
			}
			-- return opts
		end,

		--table.insert(cmp_conf.sources, { name = "cmp-nvim-r" })
		-- table.insert(M.sources, { overrides.cmp.sources })
		-- table.insert(M.formatting, { nil }) --{ overrides.cmp.formatting })
	},

	-- --------------------------------------------------------------------- }}}
	-- {{{ vimtex

	{
		"lervag/vimtex",
		ft = { "tex", "texx" },
		dependencies = { "micangl/cmp-vimtex" },
		version = "*",
		-- event = { "BufReadPre", "BufNewFile" },       -- WARNING: adding events can prevent synctex inverse search from working
		config = function()
			require("custom.configs.vimtex")
		end,
	},

	-- {
	-- 	"lervag/vimtex",
	-- 	ft = { "tex", "texx" },
	-- 	dependencies = { "Traap/vim-bundle-vimtex" },
	-- 	config = function()
	-- 		require("custom.configs.vimtex")
	-- 	end,
	-- },

	-- ----------------------------------------------------------------------- }}}
	-- {{{ which-key
	{
		"folke/which-key.nvim",
		-- opts = overrides.whichkey,
		config = function()
			require("custom.configs.which-key")
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- -- format & linting
			{
				"folke/neodev.nvim",
				opts = {},
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	{
		"stevearc/conform.nvim",
		--  for users those who want auto-save conform + lazyloading!
		-- event = "BufWritePre"
		config = function()
			require("custom.configs.conform")
		end,
	},

	-- Override plugin definition options
	--
	--

	-- override plugin configs
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		-- init = function()
		-- 	require("core.utils").load_mappings("nvimtree")
		-- end,
		opts = overrides.nvimtree,
		-- config = function(_, opts)
		-- 	dofile(vim.g.base46_cache .. "nvimtree")
		-- 	require("nvim-tree").setup(opts)
		-- end,
	},

	-- Install a plugin
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},
}

return plugins
