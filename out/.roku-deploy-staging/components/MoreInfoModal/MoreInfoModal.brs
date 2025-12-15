sub init()
    HEADER_FONT_SIZE = 24

    m.top.setFocus(true)

    m.background = m.top.findNode("background")
    m.title = m.top.findNode("title")
    m.subtitle = m.top.findNode("subtitle")
    m.workTitle = m.top.findNode("workTitle")
    m.notes = m.top.findNode("notes")
    m.infoContent = m.top.findNode("infoContent")

    m.title.font.size = HEADER_FONT_SIZE
    m.subtitle.font.size = HEADER_FONT_SIZE
    m.workTitle.font.size = HEADER_FONT_SIZE

    ' m.backgroundAnimation = m.top.findNode("backgroundAnimation")
    ' m.backgroundAnimation.repeat = false
    ' m.backgroundAnimation.control = "start"

    m.top.observeField("visible", "onVisibleChange")
end sub

' TODO: accept px and % values for distance
sub moveNode(node, direction, distance, parent = invalid)
    nodeWidth = node.boundingRect?()?.width
    nodeHeight = node.boundingRect?()?.height

    if parent = invalid then
        parent = node.getParent()
    end if
    
    parentWidth = parent.boundingRect?()?.width
    parentHeight = parent.boundingRect?()?.height
    
    if direction = "left" then
        node.translation = [distance, node.translation[1]]
    end if

    if direction = "top" then
        node.translation = [node.translation[0], distance]
    end if

    if direction = "right" then
        xPos = parentWidth - nodeWidth - distance
        node.translation = [xPos, node.translation[1]]
    end if

    if direction = "bottom" then
        yPos = parentHeight - nodeHeight - distance
        node.translation = [node.translation[0], yPos]
    end if
end sub

sub onBackgroundColorChange()
    m.background.color = m.top.backgroundColor
end sub

sub onMainColorChange()
    m.title.color = m.top.mainColor
    m.workTitle.color = m.top.mainColor
    m.infoContent.color = m.top.mainColor
    m.notes.color = m.top.mainColor
end sub

sub onSecondaryColorChange()
    m.subtitle.color = m.top.secondaryColor
end sub

sub onTitleChange()
    m.title.text = m.top.title
end sub

sub onSubtitleChange()
    m.subtitle.text = m.top.subtitle
end sub

sub onWorkTitleChange()
    m.workTitle.text = m.top.workTitle
end sub

sub onVisibleChange(event)
    if event?.getData?() then
        m.notes.closed = false
        m.infoContent.closed = false
        moveNode(m.notes, "right", 40, m.background)
        moveNode(m.notes, "bottom", 80, m.background)
        moveNode(m.infoContent, "left", 200, m.background)
        moveNode(m.infoContent, "bottom", 20, m.background)
        ' m.backgroundAnimation.control = "start"
    else
        m.notes.closed = true
        m.infoContent.closed = true
        ' ? animateOut()
    end if
end sub

sub onNotesArrayChange()
    m.notes.notesArray = m.top.notesArray
end sub

sub onLeftArrayChange()
    m.infoContent.leftArray = m.top.leftArray
end sub

sub onRightArrayChange()
    m.infoContent.rightArray = m.top.rightArray
end sub