// Confirm delete action
function confirmDeletion(resourceId) {
    document.getElementById(resourceId).style.display = "unset";
}

// Cancel delete action
function cancelDelete(resourceId) {
    document.getElementById(resourceId).style.display = "none";
}