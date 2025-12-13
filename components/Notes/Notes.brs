sub init()
    m.NOTE_WIDTH = 200
    m.NOTES_MARGIN = 20

    m.nodeArray = []
    m.top.observeField("closed", "onClosedChange")
end sub

sub onColorChange()
    for each node in m.nodeArray
        node.title.color = m.top.color
        node.description.color = m.top.color
    end for
end sub

sub onNotesArrayChange()
    for each note in m.top.notesArray
        title = CreateObject("roSGNode", "Label")
        title.text = note.title
        title.width = m.NOTE_WIDTH
        title.font = "font:TinyBoldSystemFont"
        title.font.size = 12

        if m.nodeArray.Count() > 0 then
            lastNode = m.nodeArray.peek()
            descTranslation = lastNode.description?.translation
            descHeight = lastNode.description?.boundingRect?()?.height

            if descTranslation <> invalid AND descHeight <> invalid then
                newY = descTranslation[1] + descHeight + m.NOTES_MARGIN
                title.translation = [0, newY]
            end if
        else
            title.translation = [0, 0]
        end if

        description = CreateObject("roSGNode", "Label")
        description.text = note.description
        description.width = m.NOTE_WIDTH
        description.translation = [0, title.translation[1] + 14]
        description.font.size = 10
        description.wrap = true
        description.maxLines = 3

        m.nodeArray.push({title: title, description: description})

        m.top.appendChild(title)
        m.top.appendChild(description)
    end for
    onColorChange()
end sub

sub onClosedChange(event)
    isClosed = event?.getData?()
    if isClosed <> invalid AND isClosed then
        for each node in m.nodeArray
            m.top.removeChild(node.title)
            m.top.removeChild(node.description)
        end for
        m.nodeArray = []
    end if
end sub
