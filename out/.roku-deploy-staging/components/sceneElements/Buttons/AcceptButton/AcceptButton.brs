sub init()
    m.acceptButton = m.top.findNode("Accept")
    m.acceptButton.uri = m.global.icons.search.ACCEPT_INACTIVE
    m.top.observeField("focusedChild", "onFocus")
end sub

sub onFocus()
    if m.top.hasFocus()
        m.acceptButton.uri = m.global.icons.search.ACCEPT_ACTIVE
    else
        m.acceptButton.uri = m.global.icons.search.ACCEPT_INACTIVE
    end if
end sub
