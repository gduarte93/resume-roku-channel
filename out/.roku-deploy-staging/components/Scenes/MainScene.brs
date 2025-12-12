sub init()
    rowlist = m.top.findNode("tileRow1")
    rowlist.content = CreateObject("roSGNode", "TileListContent")
    m.top.setFocus(true)
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    ' if press then
    '     m.myLabel = m.top.findNode("myLabel")

    '     if m.myLabel <> invalid
    '         m.myLabel.setFocus(true)
    '         print "valid Node"
    '     end if

    '     if (key = "up") then
    '         m.myLabel.font.size = m.myLabel.font.size + 5
    '     else if (key = "down") then
    '         m.myLabel.font.size = m.myLabel.font.size - 5
    '     end if
    ' end if
end function
