sub main()
    screen = createObject("roSGScreen")
    m.port = createObject("roMessagePort")
    scene = screen.createScene("HomeScene")
    m.global = screen.getGlobalNode()
    screen.Show()
	screen.setMessagePort(m.port)
    
    while(true)

	end while
end sub

function returnManifestData()
    manifestData = CreateObject("roAppInfo")
    return {
        "title": manifestData.getTitle()
        "version": manifestData.getVersion()
    }
end function

