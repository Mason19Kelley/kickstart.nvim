-- Utilities for creating configurations
local util = require 'formatter.util'

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require('formatter').setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    lua = {
      -- "formatter.filetypes.lua" defines default configurations for the
      -- "lua" filetype
      require('formatter.filetypes.lua').stylua,

      -- You can also define your own configuration
      function()
        -- Supports conditional formatting
        if util.get_current_buffer_file_name() == 'special.lua' then
          return nil
        end

        -- Full specification of configurations is down below and in Vim help
        -- files
        return {
          exe = 'stylua',
          args = {
            '--search-parent-directories',
            '--stdin-filepath',
            util.escape_path(util.get_current_buffer_file_path()),
            '--',
            '-',
          },
          stdin = true,
        }
      end,
    },
    javascript = {
      require('formatter.filetypes.javascript').prettier,
    },
    typescript = {
      require('formatter.filetypes.typescript').prettier,
    },
    javascriptreact = {
      require('formatter.filetypes.javascriptreact').prettier,
    },
    typescriptreact = {
      require('formatter.filetypes.typescriptreact').prettier,
    },

    -- JSON
    json = {
      require('formatter.filetypes.json').prettier,
    },

    -- CSS/SCSS
    css = {
      require('formatter.filetypes.css').prettier,
    },
    scss = {
      require('formatter.filetypes.css').prettier,
    },

    -- HTML
    html = {
      require('formatter.filetypes.html').prettier,
    },

    -- Markdown
    markdown = {
      require('formatter.filetypes.markdown').prettier,
    },
    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ['*'] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require('formatter.filetypes.any').remove_trailing_whitespace,
      -- Remove trailing whitespace without 'sed'
      -- require("formatter.filetypes.any").substitute_trailing_whitespace,
    },
  },
}

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
keymap('n', '<leader>f', '<cmd>Format<cr>', vim.tbl_extend('force', opts, { desc = 'Format buffer' }))
