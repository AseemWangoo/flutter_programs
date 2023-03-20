const form = document.querySelector('form')
const chatContainer = document.querySelector('#chat_container')
const formData = new FormData(form)

function typeText(element, text) {
    let index = 0

    let interval = setInterval(() => {
        if (index < text.length) {
            element.innerHTML += text.charAt(index)
            index++
        } else {
            clearInterval(interval)
        }
    }, 20)
}

function generateUniqueId() {
    const timestamp = Date.now();
    const randomNumber = Math.random();
    const hexadecimalString = randomNumber.toString(16);

    return `id-${timestamp}-${hexadecimalString}`;
}

function chatStripe(isAi, value, uniqueId) {
    return (
        `
        <div class="wrapper ${isAi && 'ai'}">
            <div class="chat">
                <div class="profile">
                    <img 
                    src=${isAi ? './assets/bot.svg' : './assets/user.svg'} 
                    alt="${isAi ? 'bot' : 'user'}" 
                    />
                </div>
                <div class="message" id=${uniqueId}>${value}</div>
            </div>
        </div>
    `
    )
}

// Sets up a channel to JS-interop with Flutter
(function () {
    "use strict";
    // This function will be called from Flutter when it prepares the JS-interop.
    window._stateSet = function () {
        // This is done for handler callback to be updated from Flutter as well as HTML
        window._stateSet = function () {
            // console.log('HELLO From Flutter!!')
        };

        // The state of the flutter app, see `class _MyAppState` in [src/gpt.dart].
        let appState = window._appState;

        let updateTextState = function () {
            formData.set('prompt', appState.textQuery);
            handleSubmit.call(form)
        };

        // Register a callback to update the text field from Flutter.
        appState.addHandler(updateTextState);

        // CHAT GPT FUNCTIONS
        form.addEventListener("submit", (e) => {
            handleSubmit(e)
        });

        // CHAT GPT FUNCTIONS
        form.addEventListener("keyup", (e) => {
            if (e.keyCode === 13) {
                handleSubmit(e)
            }
        });
    };
}());

const handleSubmit = async (e) => {
    // user's chatstripe
    chatContainer.innerHTML += chatStripe(false, formData.get('prompt'))

    // to clear the textarea input 
    form.reset()

    // bot's chatstripe
    const uniqueId = generateUniqueId()
    chatContainer.innerHTML += chatStripe(true, " ", uniqueId)

    // to focus scroll to the bottom 
    chatContainer.scrollTop = chatContainer.scrollHeight;

    // specific message div 
    const messageDiv = document.getElementById(uniqueId)

    const response = await fetch('http://localhost:5001/', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            prompt: formData.get('prompt')
        })
    })

    messageDiv.innerHTML = " "

    if (response.ok) {
        const data = await response.json();
        const parsedData = data.bot.trim() // trims any trailing spaces/'\n' 

        typeText(messageDiv, parsedData)
    } else {
        const err = await response.text()

        messageDiv.innerHTML = "Something went wrong"
        alert(err)
    }
}