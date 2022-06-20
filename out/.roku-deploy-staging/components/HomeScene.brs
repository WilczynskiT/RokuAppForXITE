function init()
    initGlobal()
    m.top.backgroundURI = ""
    m.top.backgroundColor = "0x000000" 
end function

function initGlobal()
    initGlobalTask = createObject("roSGNode", "InitGlobalTask")
    initGlobalTask.observeField("globalsReady", "onGlobalsReady")
    initGlobalTask.control = "run"
end function

sub onGlobalsReady(event)
    globalsReady = event.getData()
    if globalsReady
        startMainView()
    end if
end sub

sub startMainView()
    m.gridView = m.top.createChild("GridView")
    m.gridView.visible = true
    m.gridView.setFocus(true)
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if key = "up"
            m.gridView.setFocus(true)
        else if key = "down" 
            m.gridView.setFocus(false)
            m.top.setFocus(true)
        handled = true
        end if
    end if
    return handled
end function
