sub init()
    m.rowlist = m.top.findNode("tileRow1")
    m.rowlist.content = CreateObject("roSGNode", "TileListContent")
    m.backgroundImage = m.top.findNode("backgroundImage")

    m.top.setFocus(true)
    m.rowlist.setFocus(true)
    m.rowlist.observeField("rowItemFocused", "onRowItemFocused")
    ' m.rowlist.observeField("itemSelected", "onItemSelected")
end sub

' TODO: on OK bring up modal
sub onItemSelected(itemSelected)
    print "item selected:"
    print Str(itemSelected)
end sub

sub onRowItemFocused(event)
    focusedArray = event.getData()
    rowIndex = focusedArray[0]
    tileIndex = focusedArray[1]

    currentRow = m.rowlist.content.getChild(rowIndex)

    if currentRow = invalid return

    currentTile = currentRow.getChild(tileIndex)

    if currentTile = invalid return

    if currentTile.HDPosterUrl <> invalid then
        m.backgroundImage.uri = currentTile.HDPosterUrl
    end if
    
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    ' if press then
    '     if m.rowList <> invalid
    '         print key
    '         print m.rowList.itemSelected
    '         if key = "right" AND m.rowList.itemSelected > 2
    '             m.rowList.rowFocusAnimationStyle = "fixedFocus"
    '         end if

    '         ' if (key = "up") then
    '         '     m.myLabel.font.size = m.myLabel.font.size + 5
    '         ' else if (key = "down") then
    '         '     m.myLabel.font.size = m.myLabel.font.size - 5
    '         ' end if
    '     end if
    ' end if
end function
