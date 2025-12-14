sub init()
    m.INFO_WIDTH = 400
    m.PARAGRAPH_MARGIN = 12
    m.CENTER_GAP = 40

    m.nodeArrayLeft = []
    m.nodeArrayRight = []
end sub

sub onLeftArrayChange(event)
    for each data in m.top.leftArray
        title = CreateObject("roSGNode", "Label")
        title.text = data.title
        title.width = m.INFO_WIDTH
        title.font = "font:TinyBoldSystemFont"
        title.font.size = 10

        if m.nodeArrayLeft.Count() > 0 then
            lastNode = m.nodeArrayLeft.peek()
            descTranslation = lastNode.description?.translation
            descHeight = lastNode.description?.boundingRect?()?.height

            if descTranslation <> invalid AND descHeight <> invalid then
                newY = descTranslation[1] + descHeight + m.PARAGRAPH_MARGIN
                title.translation = [0, newY]
            end if
        else
            title.translation = [0, 0]
        end if

        description = CreateObject("roSGNode", "Label")
        description.text = replace(data.description, "<br/>", chr(10))
        description.width = m.INFO_WIDTH
        description.translation = [0, title.translation[1] + m.PARAGRAPH_MARGIN * 2]
        description.font.size = 10
        description.wrap = true

        m.nodeArrayLeft.push({title: title, description: description})

        m.top.appendChild(title)
        m.top.appendChild(description)
    end for
    onColorChange()
end sub

sub onRightArrayChange(event)
    for each data in m.top.rightArray
        title = CreateObject("roSGNode", "Label")
        title.text = data.title
        title.width = m.INFO_WIDTH
        title.font = "font:TinyBoldSystemFont"
        title.font.size = 10

        if m.nodeArrayRight.Count() > 0 then
            lastNode = m.nodeArrayRight.peek()
            descTranslation = lastNode.description?.translation
            descHeight = lastNode.description?.boundingRect?()?.height

            if descTranslation <> invalid AND descHeight <> invalid then
                newY = descTranslation[1] + descHeight + m.PARAGRAPH_MARGIN
                title.translation = [m.INFO_WIDTH + m.CENTER_GAP, newY]
            end if
        else
            title.translation = [m.INFO_WIDTH + m.CENTER_GAP, 0]
        end if

        description = CreateObject("roSGNode", "Label")
        description.text = replace(data.description, "<br/>", chr(10))
        description.width = m.INFO_WIDTH
        description.translation = [m.INFO_WIDTH + m.CENTER_GAP, title.translation[1] + m.PARAGRAPH_MARGIN * 2]
        description.font.size = 10
        description.wrap = true
        ' description.maxLines = 3

        m.nodeArrayRight.push({title: title, description: description})

        m.top.appendChild(title)
        m.top.appendChild(description)
    end for
    onColorChange()
end sub

' TODO move to utils
function replace(str as string, reg as string, replacement as string) as string
    r = CreateObject("roRegex", reg, "")

    return r.replaceAll(str, replacement)
end function

sub onColorChange()
    for each node in m.nodeArrayLeft
        node.title.color = m.top.color
        node.description.color = m.top.color
    end for

    for each node in m.nodeArrayRight
        node.title.color = m.top.color
        node.description.color = m.top.color
    end for
end sub

sub onClosedChange(event)
    isClosed = event?.getData?()
    if isClosed <> invalid AND isClosed then
        for each node in m.nodeArrayLeft
            m.top.removeChild(node.title)
            m.top.removeChild(node.description)
        end for

        for each node in m.nodeArrayRight
            m.top.removeChild(node.title)
            m.top.removeChild(node.description)
        end for
        m.nodeArrayLeft = []
        m.nodeArrayRight = []
    end if
end sub
