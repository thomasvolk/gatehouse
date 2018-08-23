function get(url) {
    return fetch(url)
        .then(response => response.json())
        .catch(ex => {
        alert("ERROR: " + ex);
    })
}

function put(url, body) {
    return fetch(url, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json; charset=utf-8'
        },
        body: JSON.stringify(body)
    });
}

export default {
    get: get,
    put: put
}
