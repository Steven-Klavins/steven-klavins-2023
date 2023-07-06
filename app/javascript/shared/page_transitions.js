// ==== Appear on scroll transition ====

let appearOnScroll = new IntersectionObserver(
    function (entries, appearOnScroll) {
        entries.forEach(entry => {
            if (!entry.isIntersecting) {
                return
            } else {
                entry.target.classList.add('appear');
                appearOnScroll.unobserve(entry.target)
            }
        })
    },
    {
        threshold: .1,
        // Dynamically calculate the root margin to compensate for varying screen sizes.
        rootMargin: `${((window.innerWidth * -1) / 6).toString()}px`
    }
)

// Set appearOnScroll transition for any element with fade-in class
function addScrollListeners() {
    document.querySelectorAll('.fade-in').forEach(fader => {
        appearOnScroll.observe(fader)
    })
}