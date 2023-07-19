local theme = {
  -- fill = 'TabLineFill', #c0412e
  fill = { fg='#437e90', bg='#0c0c0c', style='italic' },
  head = { fg='#db4230', bg='#0c0c0c', style='italic' },
  current_tab = 'TabLineSel',
  tab = { fg='#437e90', bg='#3c3836', style='italic' },
  win = { fg='#a8aa28', bg='#3c3836', style='italic' },
  tail = { fg='#db4230', bg='#0c0c0c', style='italic' },
}
vim.o.showtabline = 2

require('tabby.tabline').set(function(line)
  return {
    {
      { '   ', hl = theme.head },
      line.sep('', theme.head, theme.fill),
    },
    line.tabs().foreach(function(tab)
      local hl = tab.is_current() and theme.current_tab or theme.tab
      return {
        line.sep('', hl, theme.fill),
        tab.is_current() and '' or '󰆣',
        tab.number(),
        tab.name(),
        tab.close_btn(''),
        line.sep('', hl, theme.fill),
        hl = hl,
        margin = ' ',
      }
    end),
    line.spacer(),
    line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
      return {
        line.sep('', theme.win, theme.fill),
        win.is_current() and '' or '',
        win.buf_name(),
        line.sep('', theme.win, theme.fill),
        hl = theme.win,
        margin = ' ',
      }
    end),
    {
      line.sep('', theme.tail, theme.fill),
      { '    ', hl = theme.tail },
    },
    hl = theme.fill,
  }
end)
