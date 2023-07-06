/*========================
      _electronics
=========================*/

function animatePowerSupply() {
    let properties = [
        ["--percent", "<number>"],
        ["--temp", "<number>"],
        ["--v1", "<integer>"],
        ["--v2", "<integer>"],
    ]

    // Register CSS properties if they arent set yet.

    properties.forEach(property => {
        if (!window.CSS.hasOwnProperty([0])) {
            window.CSS.registerProperty({
                name: property[0],
                syntax: property[1],
                initialValue: 0,
                inherits: false,
            });
        }
    });

    // Set Interval and timeout for animation.
    setInterval(() => {
        document.querySelector(".voltage").style.setProperty("--percent", Math.random());
    }, 2000);
    setTimeout(() => {
        document.querySelector(".voltage").style.setProperty("--percent", Math.random());
    });

}