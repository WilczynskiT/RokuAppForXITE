sub init()
    m.keyboard = m.top.findNode("Keyboard")
    m.acceptButton = m.top.findNode("AcceptButton")
    m.keyboard.observeField("text", "onText")
    m.top.observeField("focusedChild", "onFocus")
    m.focusList = [m.keyboard, m.acceptButton]
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if key = "down" 
            m.keyboard.setFocus(false)
            m.acceptButton.setFocus(true)
        else if key = "up"
            m.acceptButton.setFocus(false)
            m.keyboard.setFocus(true)
        else if key = "OK" and m.acceptButton.isInFocusChain()
            m.top.acceptedText = m.keyboard.text
        end if
        handled = true
    end if
    return handled
end function
