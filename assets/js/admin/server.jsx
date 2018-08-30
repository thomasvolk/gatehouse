function setCSRFToken(token) {
    sessionStorage.setItem("csrf-token", token)
}

function getCSRFToken() {
    return sessionStorage.getItem("csrf-token")
}

function handleErrors(response) {
    if (!response.ok) {
        throw response
    }
    return response
}

function handleRespose(response) {
    setCSRFToken(response.headers.get("x-csrf-token"))
    return response.json()
}

function get(url) {
    return fetch(url)
        .then(handleErrors)
        .then(handleRespose)
}

function sendData(method, url, body) {
    return fetch(url, {
            method: method,
            headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'x-csrf-token': getCSRFToken()
            },
            body: JSON.stringify(body)
        })
        .then(handleErrors)
        .then(handleRespose)
}

function put(url, body) {
    return sendData('PUT', url, body)
}

function post(url, body) {
    return sendData('POST', url, body)
}

function del(url) {
    return fetch(url, {
        method: "DELETE",
        headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'x-csrf-token': getCSRFToken()
        }
    })
    .then(handleErrors)
    .then(handleRespose)
}

export default {
    get: get,
    put: put,
    post: post,
    del: del
}
