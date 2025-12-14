sub init()
    m.NOTE_WIDTH = 180
    m.NOTES_MARGIN = 10

    m.nodeArray = []
    m.top.observeField("closed", "onClosedChange")
end sub

sub onColorChange()
    for each node in m.nodeArray
        node.title.color = m.top.color
        node.description.color = m.top.color
        node.border.color = m.top.color
    end for
end sub

sub onNotesArrayChange()
    for each note in m.top.notesArray
        title = CreateObject("roSGNode", "Label")
        title.text = note.title
        title.width = m.NOTE_WIDTH
        title.font = "font:TinyBoldSystemFont"
        title.font.size = 10

        if m.nodeArray.Count() > 0 then
            lastNode = m.nodeArray.peek()
            borderTranslation = lastNode.border?.translation
            borderHeight = lastNode.border?.height

            if borderTranslation <> invalid AND borderHeight <> invalid then
                newY = borderTranslation[1] + borderHeight + m.NOTES_MARGIN
                title.translation = [0, newY]
            end if
        else
            title.translation = [0, 0]
        end if

        description = CreateObject("roSGNode", "Label")
        description.text = note.description
        description.width = m.NOTE_WIDTH
        description.translation = [0, title.translation[1] + 16]
        description.font.size = 10
        description.wrap = true
        description.maxLines = 3

        border = CreateObject("roSGNode", "Rectangle")
        border.width = m.NOTE_WIDTH
        border.height = 1

        descTranslation = description?.translation
        descHeight = description?.boundingRect?()?.height
        if descTranslation <> invalid AND descHeight <> invalid then
            newY = descTranslation[1] + descHeight + m.NOTES_MARGIN
            border.translation = [0, newY]
        end if

        m.nodeArray.push({title: title, description: description, border: border})

        m.top.appendChild(title)
        m.top.appendChild(description)
        m.top.appendChild(border)
    end for
    onColorChange()
end sub

sub onClosedChange(event)
    isClosed = event?.getData?()
    if isClosed <> invalid AND isClosed then
        for each node in m.nodeArray
            m.top.removeChild(node.title)
            m.top.removeChild(node.description)
            m.top.removeChild(node.border)
        end for
        m.nodeArray = []
    end if
end sub
