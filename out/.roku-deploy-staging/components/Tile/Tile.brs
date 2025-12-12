sub init()
    m.top.itemSpacings="[8, 0]"

    m.image = m.top.findNode("image")
    
    m.title = m.top.findNode("title")
    m.title.font.size = 22

    m.subtitle = m.top.findNode("subtitle")
    m.subtitle.font.size = 16

    print "init Tile"
end sub

sub showcontent()
    itemcontent = m.top.itemcontent
    uri = itemcontent.uri
    title = itemcontent.title
    subtitle = itemcontent.subtitle

    if uri = invalid then uri = "pkg:/images/DEET_Image.png" ' TODO: replace with a default image
    if title = invalid then title = "[Title Placeholder]"
    if subtitle = invalid then subtitle = "[description placeholder]"

    m.image.uri = uri
    m.title.text = title
    m.subtitle.text = subtitle
end sub

sub showfocus()
    scale = 1 + (m.top.focusPercent * 0.08)
    m.image.scale = [scale, scale]
end sub