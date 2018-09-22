import React from "react"
import Alert from "../alert"

export default class AlertBox extends React.Component {
    constructor(props) {
        super(props)
        this.state = {errorMessage: undefined, alertTye: undefined}
    }

    componentDidMount() {
        this.successCallback = Alert.onSuccess.addObserver((message) => this.update('success' ,message))
        this.dangerCallback = Alert.onDanger.addObserver((message) => this.update('danger' ,message))
        this.warningCallback = Alert.onWarning.addObserver((message) => this.update('warning' ,message))
        this.clearCallback = Alert.onClear.addObserver((e) => this.clear())
    }

    componentWillUnmount() {
        Alert.onSuccess.removeObserver( this.successCallback )
        Alert.onDanger.removeObserver( this.dangerCallback )
        Alert.onWarning.removeObserver( this.warningCallback )
        Alert.onClear.removeObserver( this.clearCallback )
    }
    
    update(alertTye, message) {
        this.setState({errorMessage: message, alertTye: alertTye})
    }

    clear() {
        this.setState({errorMessage: undefined})
    }

    render() {
        const errorMessage = this.state.errorMessage
        const alertTye = this.state.alertTye
        const alertStyle = `alert alert-${alertTye}`
        if(errorMessage) {
          return (<div className={alertStyle} role="alert">{errorMessage}</div>)
        }
        return (<div></div>)
      }
}