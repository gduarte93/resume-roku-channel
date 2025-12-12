sub init()
    m.BACKGROUND_IMAGE_DEFAULT_TRANSLATION = [0, -200]

    m.rowlist = m.top.findNode("tileRow1")
    m.rowlist.content = CreateObject("roSGNode", "TileListContent")
    m.backgroundImage = m.top.findNode("backgroundImage")
    m.previewLabel = m.top.findNode("previewLabel")

    m.top.setFocus(true)
    m.rowlist.setFocus(true)
    m.rowlist.observeField("rowItemFocused", "onRowItemFocused")
    ' m.rowlist.observeField("itemSelected", "onItemSelected")

    m.previewLabel.font.size = 16
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

    if currentTile.title = "Software Engineer" then
        m.backgroundImage.translation = [0, -250]
    else if currentTile.title = "Web Developer" then
        m.backgroundImage.translation = [0, -400]
    else
        m.backgroundImage.translation = m.BACKGROUND_IMAGE_DEFAULT_TRANSLATION
    end if

    if currentTile.description = invalid OR currentTile.description = "" then
        m.previewLabel.text = "[DEFAULT_DESCRIPTION]"
    else
        m.previewLabel.text = currentTile.description
    end if

    if m.previewLabel?.boundingRect?()?.height <> invalid then
        m.previewLabel.translation = [20, 430 - m.previewLabel?.boundingRect?()?.height]
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
