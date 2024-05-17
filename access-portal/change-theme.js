// License: CC0 https://creativecommons.org/publicdomain/zero/1.0/
// Source: https://github.com/riceissa/issarice.com/blob/master/static/change-theme.js

// We use a self-executing anonymous function to create a separate namespace
// called change_theme. This way any functions we define here won't affect
// other scripts. See https://stackoverflow.com/a/5947280/3422337 . (The
// version here is a bit different because we aren't using jQuery so we don't
// have to pass that as an argument, and modern versions of JavaScript don't
// allow you to redefine undefined so we don't need to keep that as an argument
// either.)
(function(change_theme) {
    // body classlist: blank (light) or "dark" (dark)
    // local storage: blank (meaning auto), "auto", "light", or "dark"
    // color argument: "auto", "light", or "dark"

    function add_dark() {
        if (!document.body.classList.contains("dark")) {
            document.body.classList.add("dark");
        }
    }

    function remove_dark() {
        if (document.body.classList.contains("dark")) {
            document.body.classList.remove("dark");
        }
    }

    function set_body_classlist_color(color) {
        const os_prefers_dark = window.matchMedia("(prefers-color-scheme: dark)").matches;
        if (color === "dark") {
            // If the user has specifically chosen this particular website to
            // be in dark mode, then honor that over the OS/browser-level
            // preference.
            add_dark();
        } else if (color === "light") {
            remove_dark();
        } else {
            // color === "auto"
            // If the user has not set any specific setting for this particular
            // website, or has set it to auto-mode, then use dark mode if the
            // OS/browser wants it.
            if (os_prefers_dark) {
                add_dark();
            } else {
                remove_dark();
            }
        }
    }

    function set_visual_feedback_color(color) {
        var options_list = ["auto", "light", "dark"];
        var el = document.getElementById(color + "-menu-option");
        el.style.textDecoration = "underline";
        options_list = options_list.filter(x => x !== color);
        options_list.forEach((c) => document.getElementById(c + "-menu-option").style.textDecoration = "none");
    }

    // This function runs every time the menu buttons (auto/light/dark) are
    // clicked.
    change_theme.set_color = function set_color(color) {
        set_body_classlist_color(color);
        localStorage.setItem("color", color);
        set_visual_feedback_color(color);
    };

    // This function runs once on each page load.
    change_theme.set_theme_from_local_storage = function set_theme_from_local_storage() {
        const site_specific_preferred_color = localStorage.getItem("color") || "auto";
        set_body_classlist_color(site_specific_preferred_color);
        set_visual_feedback_color(site_specific_preferred_color);
    };

    // This function runs whenever the OS/browser preference changes.
    change_theme.set_theme_when_os_preference_changes = function set_theme_when_os_preference_changes() {
        const site_specific_preferred_color = localStorage.getItem("color") || "auto";
        if (site_specific_preferred_color === "auto") {
            set_body_classlist_color(site_specific_preferred_color);
        }
    };

    // Whenever the OS/browser preference changes, try resetting the color
    // scheme. This might happen for example when someone has their OS color
    // scheme set to the movement of the sun, so that e.g. at sunset the OS
    // theme gets changed to dark mode.  Because our CSS is implemented using
    // checks for body.dark (rather than the media query in the CSS directly),
    // without the following event listener, the browser won't know to update
    // the color scheme, so if the user has auto mode set on this particular
    // website then the color scheme would only get updated whenever the user
    // either clicks the "auto" button again or reloads the page.
    const dark_mode_preference = window.matchMedia("(prefers-color-scheme: dark)");
    dark_mode_preference.addEventListener("change", e => change_theme.set_theme_when_os_preference_changes());


    // This one should not save the current setting in a cookie, because if you
    // click through to a new page, you are by definition in "movement mode" rather
    // than "absorption mode".
    change_theme.change_reader_mode = function change_reader_mode() {
        if (window.getSelection().toString() != "") {
            var closestZeroElem = window.getSelection().anchorNode.parentNode;
        } else {
            var mainElem = document.querySelector('main');
            // var mainElem = document.body;
            var childElems = mainElem.querySelectorAll('*');
            var closestZero = Infinity;
            var closestZeroElem = null;
            for (var i = 0; i < childElems.length; i++) {
                var rect = childElems[i].getBoundingClientRect();

                if (Math.abs(rect.top) < Math.abs(closestZero)) {
                    closestZeroElem = childElems[i];
                    closestZero = rect.top;
                }
            }
            // console.log(closestZeroElem);
            // console.log(closestZero);
        }

        if (document.body.classList.contains("absorption")) {
            var toc = document.querySelector('#TOC');
            if (toc) {
                var mainElem = document.querySelector('main');
                mainElem.before(toc);
                toc.style.position = 'fixed';
                toc.style.top = 0;
                toc.style.width = "150px";
                // toc.style.backgroundColor = "#eee8d5";
                mainElem.style.marginLeft = "150px";
            }

            document.body.classList.remove("absorption");
            document.getElementById("change-reader-mode-toggle").textContent = "movement";
        } else {
            var toc = document.querySelector('#TOC');
            if (toc) {
                var mainElem = document.querySelector('main');
                toc.style.position = "";
                toc.style.top = "";
                toc.style.width = "";
                // toc.style.backgroundColor = "#fdf6e3";
                mainElem.style.marginLeft = "";

                var titleBlock = document.querySelector('#title-block-header');
                titleBlock.after(toc);
            }


            document.body.classList.add("absorption");
            document.getElementById("change-reader-mode-toggle").textContent = "absorption";
        }

        closestZeroElem.scrollIntoView();
    };

    document.addEventListener('keydown', function(event) {
        if (event.key === 't' && event.target.tagName !== 'INPUT' && event.target.tagName !== 'TEXTAREA') {
            change_theme.change_reader_mode();
        }
    });
}(window.change_theme = window.change_theme || {}));
