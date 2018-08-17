function get(url) {
    return fetch(url)
        .then(response => response.json())
        .catch(ex => {
        alert("ERROR: " + ex);
    })
}

export default {
    get: get
}
