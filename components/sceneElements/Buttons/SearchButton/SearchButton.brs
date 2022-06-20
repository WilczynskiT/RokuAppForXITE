sub init()
    m.SearchButton = m.top.findNode("Search")
    m.SearchButton.uri = m.global.icons.menuIcons.SEARCH_INACTIVE
    m.top.observeField("focusedChild", "onFocus")
end sub

sub onFocus()
    if m.top.hasFocus()
        m.SearchButton.uri = m.global.icons.menuIcons.SEARCH_ACTIVE
    else
        m.SearchButton.uri = m.global.icons.menuIcons.SEARCH_INACTIVE
    end if
end sub
