sub init()
    m.showAllButton = m.top.findNode("ShowAll")
    m.showAllButton.uri = m.global.icons.menuIcons.SHOW_ALL_INACTIVE
    m.top.observeField("focusedChild", "onFocus")
end sub

sub onFocus()
    if m.top.hasFocus()
        m.showAllButton.uri = m.global.icons.menuIcons.SHOW_ALL_ACTIVE
    else
        m.showAllButton.uri = m.global.icons.menuIcons.SHOW_ALL_INACTIVE
    end if
  end sub
