import Dispatcher from "./dispatcher"

const BASE_PATH = "/api/admin"

function toUrl(path) {
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
        throw response
    }
    Dispatcher.onError.update(undefined)
    return response
}

function setCSRFTokenFromResponse(response) {
    setCSRFToken(response.headers.get("x-csrf-token"))
    return response
}

function getJsonBody(response) {
    return response.json()
}

function request(path, data = undefined) {
    const url = toUrl(path)
    return fetch(url, data)
        .then(setCSRFTokenFromResponse)
        .then(handleErrors)
        .then(getJsonBody)
        .catch( (response) => {
            response.json()
                .then((resp) => Dispatcher.onError.update(resp.error))
                .catch( (error) => {
                    Dispatcher.onError.update("unknown error") 
                })
        })
} 

function sendData(method, path, body) {
    return request(path, {
            method: method,
            headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'x-csrf-token': getCSRFToken()
            },
            body: JSON.stringify(body)
        })
}

function get(path) {
    return request(path)
}

function put(path, body) {
    return sendData('PUT', path, body)
}

function post(path, body) {
    return sendData('POST', path, body)
}

function del(path) {
    return request(path, {
        method: "DELETE",
        headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'x-csrf-token': getCSRFToken()
        }
    })
}

export default {
    get: get,
    put: put,
    post: post,
    del: del
}
