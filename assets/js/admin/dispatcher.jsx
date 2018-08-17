
class Observable {

    constructor() {
        this.observer = []
     }

     addObserver(obs) {
        this.observer = this.observer.concat(obs)
     }

     removeObserver(obs) {
        this.observer = this.observer.filter( o => o !== obs )
     }

     update(parameter) {
        this.observer.forEach(o => o(parameter));
     }
 
}

export default class Dispatcher {
    
    constructor() {
       this.pricipalSelectedObservable = new Observable()
    }

    pricipalSelected(principalId) {
        console.log("Dispatcher: " + principalId)
    }
}
