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
    let validRegex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

    let is_valid = true;
    formInputs.forEach(input => {
        if (input.type !== "submit" && input.type !== "hidden" && input.value.length < 1) {
            is_valid = false;
        }
        if (input.type === "email" && !input.value.match(validRegex)) {
            is_valid = false;
        }
    });

    textInputs.forEach(input => {
        if (input.type !== "submit" && input.type !== "hidden" && input.value.length < 1) {
            is_valid = false;
        }
    });

    let submitButton = document.getElementById("submit-contact-form");

    // Conditionally disable and enable submit button
    if (is_valid) {
        submitButton.disabled = false;
        submitButton.style = "background-color: #2a2a2a; pointer-events: all;"
    }

    else {
        submitButton.disabled = true;
        submitButton.style = "background-color: #dcdcdc; pointer-events: none;"
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