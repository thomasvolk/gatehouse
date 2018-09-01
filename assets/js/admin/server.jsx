import Dispatcher from "./dispatcher"

const BASE_PATH = "/api"

function url(path) {
    return `${BASE_PATH}/${path}`
}

function setCSRFToken(token) {
    sessionStorage.setItem("csrf-token", token)
}

function getCSRFToken() {
    return sessionStorage.getItem("csrf-token")
}

function handleErrors(response) {
    if (!response.ok) {
        if(response.status == 401 || response.status == 403) {
            Dispatcher.onError.update("Unauthorized!")
        }
        throw response
    }
    return response
}

function handleRespose(response) {
    setCSRFToken(response.headers.get("x-csrf-token"))
    return response.json()
}

function get(path) {
    return fetch(url(path))
        .then(handleErrors)
        .then(handleRespose)
}

function sendData(method, path, body) {
    return fetch(url(path), {
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

function put(path, body) {
    return sendData('PUT', path, body)
}

function post(path, body) {
    return sendData('POST', path, body)
}

function del(path) {
    return fetch(url(path), {
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
