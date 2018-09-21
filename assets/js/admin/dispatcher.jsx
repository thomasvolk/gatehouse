
class Observable {

    constructor() {
        this.observer = []
     }

     addObserver(obs) {
        this.observer = this.observer.concat(obs)
        return obs
     }

     removeObserver(obs) {
        this.observer = this.observer.filter( o => o !== obs )
     }

     update(parameter) {
        this.observer.forEach(o => o(parameter));
     }
 
}

class Dispatcher extends Observable {
    constructor() {
        super()
        this.principalSelected = this.observable('principalSelected')
        this.principalChanged = this.observable('principalChanged')
        this.principalCreated = this.observable('principalCreated')
        this.principalDeleted = this.observable('principalDeleted')
        this.roleCreated = this.observable('roleCreated')
        this.roleDeleted = this.observable('roleDeleted')
        this.roleSelected = this.observable('roleSelected')
        this.onError = new Observable()
    }

    observable(eventType) {
        const o = new Observable()
        o.addObserver( (item) => this.update({ eventType: eventType, message: item}) )
        return o
    }
}

const DISPATCHER = new Dispatcher()

export default DISPATCHER