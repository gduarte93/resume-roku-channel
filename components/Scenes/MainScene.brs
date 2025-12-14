sub init()
    m.BACKGROUND_IMAGE_DEFAULT_TRANSLATION = [0, -200]

    m.rowlist = m.top.findNode("tileRow1")
    m.rowlist.content = CreateObject("roSGNode", "TileListContent")
    m.backgroundImage = m.top.findNode("backgroundImage")
    m.previewLabel = m.top.findNode("previewLabel")

    m.top.setFocus(true)
    m.rowlist.setFocus(true)
    m.rowlist.observeField("rowItemFocused", "onRowItemFocused")
    m.rowlist.observeField("itemSelected", "onItemSelected")

    m.previewLabel.font.size = 16

    m.moreInfoModal = m.top.findNode("moreInfoModal")
    m.moreInfoModal.visible = false
    m.moreInfoModal.translation = [0, 100]
end sub

sub onItemSelected(itemSelected)
    if m.moreInfoModal <> invalid AND (m.currentTile.programID <> invalid AND m.currentTile.programID <> "") then
        jsonString = ReadAsciiFile("pkg:" + m.currentTile.programID)
        jsonObj = ParseJson(jsonString)
        
        if jsonObj <> invalid then
            m.moreInfoModal.title = jsonObj.header?.title
            m.moreInfoModal.subtitle = jsonObj.header?.subtitle
            m.moreInfoModal.workTitle = jsonObj.header?.info?.description
            m.moreInfoModal.notesArray = jsonObj.header?.blurbs
            m.moreInfoModal.leftArray = jsonObj.header?.info?.story?.column1
            m.moreInfoModal.rightArray = jsonObj.header?.info?.story?.column2
            m.moreInfoModal.backgroundColor = jsonObj.header?.backgroundColor
            m.moreInfoModal.mainColor = jsonObj.header?.info?.color?.primary
            m.moreInfoModal.secondaryColor = jsonObj.header?.info?.color?.secondary
        end if
        
        toggleInfoModal()
    end if
end sub

sub onRowItemFocused(event)
    focusedArray = event.getData()
    rowIndex = focusedArray[0]
    tileIndex = focusedArray[1]

    currentRow = m.rowlist.content.getChild(rowIndex)

    if currentRow = invalid return

    m.currentTile = currentRow.getChild(tileIndex)

    if m.currentTile = invalid return

    if m.currentTile.HDPosterUrl <> invalid then
        m.backgroundImage.uri = m.currentTile.HDPosterUrl
    end if

    if m.currentTile.title = "Software Engineer" then
        m.backgroundImage.translation = [0, -250]
    else if m.currentTile.title = "Web Developer" then
        m.backgroundImage.translation = [0, -400]
    else
        m.backgroundImage.translation = m.BACKGROUND_IMAGE_DEFAULT_TRANSLATION
    end if

    if m.currentTile.description = invalid OR m.currentTile.description = "" then
        m.previewLabel.text = "[DEFAULT_DESCRIPTION]"
    else
        m.previewLabel.text = m.currentTile.description
    end if

    if m.previewLabel?.boundingRect?()?.height <> invalid then
        m.previewLabel.translation = [40, 430 - m.previewLabel?.boundingRect?()?.height]
    end if
    
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if press then
        print key
        if key = "back" then
            if m.moreInfoModal?.visible then
                toggleInfoModal()
            end if
            handled = true
        end if
    end if
    return handled
end function

sub toggleInfoModal()
    if m.moreInfoModal <> invalid
        if m.moreInfoModal.visible then
            m.moreInfoModal.visible = false
            m.moreInfoModal.setFocus(false)
            m.rowlist.setFocus(true)
        else
            m.moreInfoModal.visible = true
            m.moreInfoModal.setFocus(true)
            ' TODO: add audio track (disney sound?, espn sound, city center sound, UF crowd/stadium sound, etc)
        end if
    end if
end sub
