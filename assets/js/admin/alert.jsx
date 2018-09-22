import Dispatcher from './dispatcher'
import Observable from './observable'

class Alert {
    constructor() {
        this.onSuccess = new Observable()
        this.onWarning = new Observable()
        this.onDanger = new Observable()
        this.onClear = new Observable()
        Dispatcher.addObserver((m) => this.onClear.update(m))
    }

    success(message) {
        this.onSuccess.update(message)
    }

    warning(message) {
        this.onWarning.update(message)
    }

    danger(message) {
        this.onDanger.update(message)
    }
}

const ALERT = new Alert()

export default ALERT

