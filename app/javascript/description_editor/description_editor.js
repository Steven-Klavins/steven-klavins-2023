function resizeTextArea(editor) {
    let editorTextArea = editor.getElementsByTagName('textarea')[0]
    editorTextArea.style.height = `${10+editorTextArea.scrollHeight}px`;
}

// Toggle editor to show.
function showEditor(description_id) {
    let editor = document.getElementById(`${description_id}-editor`);
    editor.style.display = "block"
    resizeTextArea(editor)
    document.getElementById(description_id).style.display = "none"
}

// Toggle editor to close.
function closeEditor(description_id) {
    let editorId = `${description_id}-editor`;
    document.getElementById(editorId).style.display = "none"
    document.getElementById(description_id).style.display = "block"
}