-- Personal overrides on top of LazyVim.
--
-- Rule of thumb: if LazyVim or one of the extras in `lazyvim.json` already
-- configures something, do not repeat it here. Everything below is either a
-- plugin LazyVim does not ship, or a deliberate delta from its defaults.

return {
  -----------------------------------------------------------------------------
  -- Colorschemes
  -----------------------------------------------------------------------------
  { "rafalbromirski/vim-aurora" },
  { "NLKNguyen/papercolor-theme" },

  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      contrast = "hard",
      palette_overrides = {
        dark0_hard = "#060606",
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -----------------------------------------------------------------------------
  -- LSP
  -----------------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Erlang. Not covered by any extra.
        --
        -- ELP (Meta's Erlang Language Platform) rather than erlang_ls: the
        -- latter is archived upstream and its dependency chain no longer
        -- compiles against OTP 27+, where `catch ...` became a deprecation
        -- error under `warnings_as_errors`.
        elp = {},

        clangd = {
          cmd = {
            "clangd",
            "--fallback-style=webkit",
          },
        },

        -- The `lang.go` extra already supplies the full gopls config; these are
        -- the only two deltas from it. `directoryFilters` has to be restated in
        -- full because lists are replaced rather than merged.
        gopls = {
          settings = {
            gopls = {
              analyses = {
                fieldalignment = false,
              },
              directoryFilters = {
                "-.git",
                "-.vscode",
                "-.idea",
                "-.vscode-test",
                "-node_modules",
                "-.nvim",
              },
            },
          },
        },
      },
    },
  },

  -----------------------------------------------------------------------------
  -- Tooling
  -----------------------------------------------------------------------------
  {
    -- Referenced by short name: the plugin moved from `williamboman` to
    -- `mason-org`, and lazy.nvim resolves overrides by name either way.
    "mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "shellcheck" })
    end,
  },

  -----------------------------------------------------------------------------
  -- Markdown preview, exposed on the network
  -----------------------------------------------------------------------------
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_open_to_the_world = 1
      vim.g.mkdp_port = "8894"
      vim.g.mkdp_open_ip = "0.0.0.0"
      vim.g.mkdp_echo_preview_url = 1
    end,
  },

  -----------------------------------------------------------------------------
  -- Editing
  -----------------------------------------------------------------------------
  {
    "numToStr/Comment.nvim",
    opts = {},
    lazy = false,
  },
}
