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
    if m.moreInfoModal <> invalid
        toggleInfoModal()
    end if
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
            m.moreInfoModal.notesArray = [
				{
					title: "Location",
					description: "Bristol, CT"
				},
				{
					title: "Brand Migrations",
					description: "Worked on migrating legacy sites for ABC, Disneynow, Nat Geo TV, and FX to our new tech stack"
				},
				{
					title: "ESPN Watch",
					description: "Was on the team responsible for the redesigned Watch web experience"
				}
			]
            m.moreInfoModal.leftArray = [
				{
					title: "What I Do",
					description: "With the transition from ESPN to DTCI, I got the opportunity to join the Site Development team. This team is focused on creating new features and products. And, because we are now part of DTCI, that means we have access to not just ESPN products, but to all of Disney’s global brands."
				},
				{
					title: "Early On",
					description: "One of my first projects here was in helping with the migration of ESPN from our old servers to AWS. This included updating our routes in haproxy with lua and regex, as well as adding test coverage for those new rules. I worked with other teams to help validate the new routes by running automated tests, allowing for rapid turn around."
				},
				{
					title: "The Shift",
					description: "After that project, my focus shifted away from ESPN, and towards other brands. It became more and more apparent that we were now a part of a much larger Disney organization."
				}
			]
            m.moreInfoModal.rightArray = [
				{
					title: invalid,
					description: "At ESPN we created our own front end framework based around Node, React, and MobX. A large goal for us was to migrate our other properties to the same stack. Getting everyone to use the same technology would allow for the ability to share code and components between brands." + chr(10) + chr(10) + "As part of this effort, I worked on migrating the ABC local news sites, abc.com, and disneynow.com, as well as helping with the migrations of National Geographic TV and FX."
				},
				{
					title: "Recently",
					description: "Most recently, I worked on the new redesigned version of ESPN Watch, using our latest React framework. There, I worked on the listings page, the roadblock page, the schedule page, and integrating analytics for page and video tracking."
				}
			]

            m.moreInfoModal.visible = true
            m.moreInfoModal.setFocus(true)
            ' TODO: add audio track (disney sound?, espn sound, city center sound, UF crowd/stadium sound, etc)
        end if
    end if
end sub
