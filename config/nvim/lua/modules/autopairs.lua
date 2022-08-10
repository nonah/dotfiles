local npairs = require('nvim-autopairs')

npairs.setup({
  disable_filetype = { "TelescopePrompt" },
  check_ts = true,
  map_bs = true,
  map_c_w = true,
  fast_wrap = {
    map = "<M-e>"
  },
  enable_afterquote = true,
  enable_moveright = true,
  enable_check_bracket_line = true,
  ts_config = {
  }
})

local test = function()
end

local Rule = require'nvim-autopairs.rule'

npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    end, nil),
  Rule('( ', ' )')
    :with_pair(function() return false end, nil)
    :with_move(function(opts)
      return opts.prev_char:match('.%)') ~= nil
    end)
    :use_key(')'),
  Rule('{ ', ' }')
    :with_pair(function() return false end, nil)
    :with_move(function(opts)
      return opts.prev_char:match('.%}') ~= nil
    end)
    :use_key('}'),
  Rule('[ ', ' ]')
    :with_pair(function() return false end, nil)
    :with_move(function(opts)
      return opts.prev_char:match('.%]') ~= nil
    end)
    :use_key(']')
}
