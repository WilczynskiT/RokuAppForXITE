sub init()
    m.top.functionName = "setGlobalsState"
end sub

sub setGlobalsState()
    m.global.addField("icons", "assocarray", false)
    m.global.icons = getIcons()
    m.top.globalsReady = true
end sub
