// Sets up a channel to JS-interop with Flutter
(function () {
    "use strict";
    // This function will be called from Flutter when it prepares the JS-interop.
    window._stateSet = function () {
        // This is done for handler callback to be updated from Flutter as well as HTML
        window._stateSet = function () {
            console.log('HELLO From Flutter!!')
        };

        // The state of the flutter app, see `class _MyAppState` in [src/client.dart].
        let appState = window._appState;

        // Get the input box i.e `value`
        let valueField = document.querySelector("#value");
        let updateState = function () {
            valueField.value = appState.count; // Function present inside the `client.dart`
        };

        // Register a callback to update the HTML field from Flutter.
        appState.addHandler(updateState);

        // Render the first value (0).
        updateState();

        // Get the increment button
        let incrementButton = document.querySelector("#increment");
        incrementButton.addEventListener("click", (event) => {
            appState.increment();   // Function present inside the `client.dart`
        });

        // Get the google button
        let googleButton = document.querySelector("#google");
        googleButton.addEventListener("click", (event) => {
            appState.getValue('google.com');   // Function present inside the `client.dart`
        });

        // Get the flutter button
        let flutterButton = document.querySelector("#flutter");
        flutterButton.addEventListener("click", (event) => {
            appState.getValue('flutter.dev');   // Function present inside the `client.dart`
        });

        // Get the show/hide button
        let showHideButton = document.querySelector("#btnVisible");
        showHideButton.addEventListener("click", (event) => {
            var res = showHide();
            appState.showHideValue(res);   // Function present inside the `client.dart`
        });


        let updateText = function () {
            showHideButton.value = appState.showHideNav; // Function present inside the `client.dart`
        };
        // Register a callback to update the button field from Flutter.
        appState.addHandler(updateText);
        updateText();

        // Show hide div
        function showHide() {
            var x = document.getElementById("nav_controls");
            var shown = false;
            if (x.style.display === "none") {
                x.style.display = "block";
                shown = true;
            } else {
                x.style.display = "none";
                shown = false;
            }

            return shown;
        }
    };
}());