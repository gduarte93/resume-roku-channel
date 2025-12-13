sub init()
    HEADER_FONT_SIZE = 18

    m.top.setFocus(true)

    m.background = m.top.findNode("background")
    m.title = m.top.findNode("title")
    m.subtitle = m.top.findNode("subtitle")
    m.workTitle = m.top.findNode("workTitle")

    m.title.font.size = HEADER_FONT_SIZE
    m.subtitle.font.size = HEADER_FONT_SIZE
    m.workTitle.font.size = HEADER_FONT_SIZE

    ' print m.top.notesArray
end sub

sub onBackgroundColorChange()
    m.background.color = m.top.backgroundColor
end sub

sub onMainColorChange()
    m.title.color = m.top.mainColor
    m.workTitle.color = m.top.mainColor
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

sub onNotesArrayChange()
    NOTE_WIDTH = 100

    for each note in m.top.notesArray
        title = CreateObject("roSGNode", "Label")
        title.text = note.title
        title.width = NOTE_WIDTH
        title.font.color = m.top.mainColor

        description = CreateObject("roSGNode", "Label")
        description.text = note.description
        description.width = NOTE_WIDTH
        description.font.color = m.top.mainColor

        m.top.appendChild(title)
        m.top.appendChild(description)

        ' print note.title
        ' print note.description
    end for
end sub