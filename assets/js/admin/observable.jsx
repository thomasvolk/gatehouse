
export default class Observable {

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