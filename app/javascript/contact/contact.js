// === Copy Events ===

// Attempt to copy email to clipboard providing permissions are correct.
const Clipboard = () => {
    const copyText = async (text) => {
        try {
            await navigator.clipboard.writeText(text);
            flashCopyEvent()

        } catch (error) {
            alert(`Failed to copy text to clipboard: ${error.message}`);
        }
    };
    return {
        copyText
    };
};

// Upon successful copying of email flash the success message
function flashCopyEvent() {
    let notice = document.getElementById("copy-event")
    let description = document.getElementById("copy-description")
    description.style = "display: none!important;"
    notice.classList.add("active")

    setTimeout(function () {
        notice.classList.remove("active")

    }, 1500)

    // add an additional timeout for the copy message to enable smooth fade transitions.
    setTimeout(function () {
        description.style = "display: inline-block;"
    }, 1700)
}

// === Contact Form ===

// Validate the form email and text inputs
function validateContactForm(formInputs, textInputs) {
    let is_valid = true;

    formInputs.forEach(input => {
        if (!fieldIsValid(input)) {
            is_valid = false
        }
    });

    textInputs.forEach(input => {
        if (!fieldIsValid(input)) {
            is_valid = false
        }
    });

    let submitButton = document.getElementById("submit-contact-form");
    submitButtonEnabled(submitButton, is_valid)
}

// Enable submit when appropriate.
function submitButtonEnabled(submitButton, is_valid) {
    let message = document.getElementById("contact-form-msg")
    if (is_valid) {
        submitButton.disabled = false;
        submitButton.style = "background-color: #2a2a2a; pointer-events: all;"
    } else {
        submitButton.disabled = true;
        submitButton.style = "background-color: #dcdcdc; pointer-events: none;"
    }
}

// Check form field is valid.
function fieldIsValid(input) {
    if (input.type !== "submit" && input.type !== "hidden" && input.value.length < 1) {
        return false;
    }
    if (input.type === "email") {
        if (!validEmail(input)) {
            return false;
        }
    }
    return true
}

// Change field colour based on validity.
function fieldIsValidColor(input) {
    if(fieldIsValid(input) || input.value.length == 0) {
        input.style.color = "black"
        input.style.borderBottom = "1px solid #2a2a2a";
    }
    else if(input.value.length > 0) {
        input.style.color = "red"
        input.style.borderBottom = "1px solid red";
    }
}

// Reset the field colour on focus
function resetColor(input) {
    input.style.color = "black"
    input.style.borderBottom = "1px solid #2a2a2a";
}

// Check email validity
function validEmail(input) {
    let validRegex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

    if (input.value.match(validRegex)) {
        return true
    } else {
        return false
    }
}

// Add event listeners for live validation
function addContactFormValidationListeners() {
    let formInputs = document.querySelectorAll("input")
    let textInputs = document.querySelectorAll("textarea")

    formInputs.forEach(input => {
        if (input.type !== "submit" && input.type !== "hidden") {
            input.addEventListener("input", function () {
                validateContactForm(formInputs, textInputs)
            });
        }
    });

    textInputs.forEach(input => {
        if (input.type !== "submit" && input.type !== "hidden") {
            input.addEventListener("input", function () {
                validateContactForm(formInputs, textInputs)
            });
        }
    });

    validateContactForm(formInputs, textInputs)
}