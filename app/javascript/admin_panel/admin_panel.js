function toggleDraftsOn() {
    let draftToggleButton = document.getElementById("draft-toggle-button")
    draftToggleButton.innerHTML = "Drafts &#9206;"
    draftToggleButton.setAttribute('onclick', 'toggleDraftsOff()')
    document.getElementById("blog-drafts-list").style.display = "block"
    // Up
}

function toggleDraftsOff() {
    let draftToggleButton = document.getElementById("draft-toggle-button")
    draftToggleButton.innerHTML = "Drafts &#9207;"
    draftToggleButton.setAttribute('onclick', 'toggleDraftsOn()')
    document.getElementById("blog-drafts-list").style.display = "none"
}