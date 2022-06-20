sub init()
    m.logo = m.top.findNode("Logo")
    m.logo.uri = m.global.icons.logos.LOGO
    m.menuPlaceholder = m.top.findNode("ButtonsPlaceholder")
    m.itemsGrid = m.top.findNode("ItemsGrid")
    m.gridViewElements = m.top.findNode("GridViewElements")
    m.videoPlayer = m.top.findNode("VideoPlayer")
    m.gridBackground = m.top.findNode("GridBackground")
    m.searchBackground = m.top.findNode("SearchBackground")
    m.search = m.top.findNode("Search")
    m.search.observeField("acceptedText", "onAcceptedText")
    m.top.observeField("focusedChild", "onFocus")
    loadContent()
    m.playerState = "" 
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if key = "up"
            m.menuPlaceholder.setFocus(true)
        else if key = "down" 
            m.menuPlaceholder.setFocus(false)
            m.itemsGrid.setFocus(true)
        else if key = "right"
            increaseMenuIndex() 
        else if key = "left"
            decreaseMenuIndex()
        else if key = "OK" and m.itemsGrid.isInFocusChain()
            startPlayback()
        else if key = "OK" and m.menuPlaceholder.isInFocusChain()
            buttonAction()
        else if key = "back"
            stopPlayback()
        end if
        handled = true
    end if
    return handled
end function

sub startPlayback()
    m.gridViewElements.visible = false
    samplePlaybackData = getSamplePlaybackData()
    m.videoPlayer.EnableCookies()
    m.videoPlayer.setCertificatesFile("common:/certs/ca-bundle.crt")
    m.videoPlayer.InitClientCertificates()
    m.videoPlayer.notificationInterval=1
    m.videoPlayer.visible = true
    m.videoPlayer.setFocus(true)
    m.videoPlayer.content = samplePlaybackData
    m.videoPlayer.control = "play"
end sub

sub stopPlayback()
    m.videoPlayer.control = "stop"
    m.gridViewElements.visible = true
    m.itemsGrid.setFocus(true)
end sub

sub buttonAction()
    action = m.menuPlaceholder.buttons[m.menuPlaceholder.selectedItemIndex].id
    if action = "ShowAllButton"
        loadContent()
    else if action = "SearchButton"
        m.gridBackground.visible = false
        m.searchBackground.visible = true
        m.search.visible = true
        m.search.setFocus(true)
    end if
end sub

sub reFocus()
    m.gridBackground.visible = true
    m.searchBackground.visible = false
    m.search.visible = false
    m.search.setFocus(false)
    m.itemsGrid.setFocus(true)
end sub

sub onAcceptedText(event)
    searchText = event.getData()
    reFocus()
    loadContent(searchText)
end sub

function getSamplePlaybackData()
    node = createObject("roSGNode","ContentNode")
    node.streamformat = "mp4"
    node.url = "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_5mb.mp4"
    return node
end function

sub increaseMenuIndex()
    buttonsCount = m.menuPlaceholder.buttons.count()
    if m.menuPlaceholder.isInFocusChain() and (m.menuPlaceholder.selectedItemIndex + 1) < buttonsCount
        m.menuPlaceholder.selectedItemIndex ++
    end if
end sub

sub decreaseMenuIndex()
    if m.menuPlaceholder.isInFocusChain() and (m.menuPlaceholder.selectedItemIndex - 1) >= 0
        m.menuPlaceholder.selectedItemIndex --
    end if
end sub

sub loadContent(searchText = "" as string)
    contentRequest = createObject("roSGNode", "ContentRequest")
    contentRequest.observeField("mappedData", "setToGrid")
    contentRequest.searchText = searchText
    contentRequest.url = "https://raw.githubusercontent.com/XiteTV/frontend-coding-exercise/main/data/dataset.json"
    contentRequest.control = "run" 'TODO: url to config
end sub

sub setToGrid(event)
    mappedData = event.getData()
    m.itemsGrid.content = mappedData
end sub
