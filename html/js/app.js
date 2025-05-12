const cinematicBars = document.querySelector('.cinematic-bars');
const textBox = document.querySelector('.cinematic-bars .text-box');
const playerNameElement = document.querySelector('.cinematic-bars .player-name');
const textElement = document.querySelector('.cinematic-bars .text');
const notificationsContainer = document.querySelector('.notifications-container');

window.addEventListener('message', function(event) {
    const data = event.data;
    switch (data.type) {
        case 'SHOW_CINEMATIC':
            showCinematic(data.state, data.text, data.playerName);
            break;
        case 'SHOW_NOTIFICATION':
            showNotification(data.message, data.notificationType, data.duration);
            break;
    }
});

function showCinematic(state, text, playerName) {
    if (state) {
        if (text) textElement.textContent = text;
        if (playerName) playerNameElement.textContent = playerName;
        cinematicBars.classList.add('active');
        const sound = document.getElementById('cinematic-sound');
        if (sound) {
            sound.currentTime = 0;
            sound.volume = 0.5;
            sound.play().catch(e => console.error('Erreur lors de la lecture du son:', e));
        }
        sendCallback('cinematicShown');
    } else {
        cinematicBars.classList.remove('active');
        setTimeout(() => {
            textElement.textContent = 'Bienvenue';
            playerNameElement.textContent = 'UNDEFINED';
        }, 1000);

        sendCallback('cinematicHidden');
    }
}

function showNotification(message, type = 'info', duration = 3000) {
    const notification = document.createElement('div');
    notification.className = `notification ${type}`;
    notification.textContent = message;

    notificationsContainer.appendChild(notification);
    
    setTimeout(() => {
        notification.classList.add('show');
    }, 10);
    
    setTimeout(() => {
        notification.classList.remove('show');
        setTimeout(() => {
            notification.remove();
        }, 300);
    }, duration);
}

function sendCallback(action, data = {}) {
    fetch(`https://${GetParentResourceName()}/${action}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify(data)
    }).catch(error => console.error('Error:', error));
}

function GetParentResourceName() {
    if (window.invokeNative) {
        try {
            return window.invokeNative('getResourceName', '');
        } catch(e) {
            return 'core';
        }
    }
    return 'core';
}
