sub init()
    m.top.observeField("focusedChild", "onFocus")
    m.showAllButton = m.top.findNode("ShowAllButton")
    m.SearchButton = m.top.findNode("SearchButton")
    m.top.observeField("selectedItemIndex", "onSelectedItemIndex")
    m.top.buttons = [m.showAllButton, m.SearchButton]
end sub

sub onFocus(event)
    focus = event.getData()
    lostFocus = not check(focus)
    if m.top.hasFocus()
        m.top.buttons[m.top.selectedItemIndex].setFocus(true)
    else if lostFocus
        m.top.buttons[m.top.selectedItemIndex].setFocus(false)
        m.top.setFocus(true)
    end if
end sub

sub onSelectedItemIndex(event)
    index = event.getData()
    if m.top.isInFocusChain()
        m.top.buttons[m.top.selectedItemIndex].setFocus(true)
    end if
end sub
