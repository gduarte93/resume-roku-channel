sub init()
    m.image = m.top.findNode("image")
    m.overlay = m.top.findNode("opacityOverlay")
    
    m.title = m.top.findNode("title")
    m.title.font.size = 22

    m.subtitle = m.top.findNode("subtitle")
    m.subtitle.font.size = 16

    m.title.color = "&hFFFFFF80"
    m.subtitle.color = "&hAAAAAA80"
    m.overlay.visible = true
end sub

sub showcontent()
    itemcontent = m.top.itemcontent
    uri = itemcontent.HDPosterUrl
    title = itemcontent.title
    subtitle = itemcontent.description

    if uri = invalid OR uri = "" then uri = "pkg:/images/DEET_Image.png" ' TODO: replace with a default image
    if title = invalid OR title = "" then title = "[Title Placeholder]"
    if subtitle = invalid OR subtitle = "" then subtitle = "[description placeholder]"

    m.image.uri = uri
    m.title.text = title
    m.subtitle.text = subtitle
end sub

sub showfocus()
    if m.top.focusPercent > 0.5
        m.overlay.visible = false
        m.title.color = "&hFFFFFFFF"
        m.subtitle.color = "&hAAAAAAFF"
    else
        m.overlay.visible = true
        m.title.color = "&hFFFFFF80"
        m.subtitle.color = "&hAAAAAA80"
    end if
end sub