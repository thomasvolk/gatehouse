import React from "react"
import Dispatcher from "../dispatcher"

export default class AlertBox extends React.Component {
    constructor(props) {
        super(props)
        this.state = {errorMessage: undefined}
    }

    componentDidMount() {
        this.onErrorCallback = Dispatcher.onError.addObserver((message) => this.update(message))
    }

    update(message) {
        this.setState({errorMessage: message})
    }

    componentWillUnmount(){
        if(this.onErrorCallback) {
            Dispatcher.onError.removeObserver( this.onErrorCallback )
        }
        this.onErrorCallback = undefined
    }

    render() {
        const errorMessage = this.state.errorMessage
        if(errorMessage) {
          return (<div className="alert alert-warning" role="alert">{errorMessage}</div>)
        }
        return (<div></div>)
      }
}