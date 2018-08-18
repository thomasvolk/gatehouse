
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

class Dispatcher {
    
    constructor() {
       this.pricipalSelectedObservable = new Observable()
    }

    pricipalSelected(principalId) {
        console.log("Dispatcher: " + principalId)
    }
}

const DISPATCHER = new Dispatcher() 

export  default DISPATCHER