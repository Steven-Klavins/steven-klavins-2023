import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    static targets = ["editor", "button", "description"]

    toggleEditorVisibility() {
        this.editorTarget.style.display = this.editorTarget.style.display === "block" ? "none" : "block"
        this.buttonTarget.style.display = this.buttonTarget.style.display === "none" ? "" : "none"
        this.descriptionTarget.style.display = this.descriptionTarget.style.display === "none" ? "" : "none"
    }
}