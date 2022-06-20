sub init()
    m.contentGrid = m.top.FindNode("ContentGrid")
    m.top.observeField("focusedChild", "onFocus")
    m.top.observeField("content", "onContent")
end sub

sub showpostergrid(content)
    m.contentGrid.content = content
    m.contentGrid.visible = true
    m.contentGrid.setFocus(true)
end sub

sub onFocus(event)
    focus = event.getData()
    if m.top.hasFocus()
        m.contentGrid.setFocus(true)
    end if
end sub

sub onContent(event)
    data = event.getData()
    postercontent = createObject("roSGNode","ContentNode")
    for each item in data
        node = createObject("roSGNode","ContentNode")
        node.HDGRIDPOSTERURL = item.cover
        node.SHORTDESCRIPTIONLINE1 = item.artist
        node.SHORTDESCRIPTIONLINE2 = item.title
        postercontent.appendChild(node)
    end for
    showpostergrid(postercontent)
end sub
