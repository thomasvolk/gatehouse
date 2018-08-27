function setCSRFToken(token) {
    sessionStorage.setItem("csrf-token", token)
}

function getCSRFToken() {
    return sessionStorage.getItem("csrf-token")
}

function get(url) {
    return fetch(url)
        .then(response => {
            setCSRFToken(response.headers.get("x-csrf-token"))
            return response.json()
        })
        .catch(ex => {
        alert("ERROR: " + ex);
    })
}

function sendData(method, url, body) {
    return fetch(url, {
        method: method,
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'x-csrf-token': getCSRFToken()
        },
        body: JSON.stringify(body)
    }).then(response => {
        setCSRFToken(response.headers.get("x-csrf-token"))
        return response.json()
    });
}

function put(url, body) {
    return sendData('PUT', url, body)
}

function post(url, body) {
    return sendData('POST', url, body)
}

export default {
    get: get,
    put: put,
    post: post
}
