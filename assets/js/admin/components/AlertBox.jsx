import React from "react"

export default class AlertBox extends React.Component {
    constructor(props) {
        super(props)
    }

    render() {
        const errorMessage = this.props.errorMessage
        if(errorMessage) {
          return (<div className="alert alert-warning" role="alert">{errorMessage}</div>)
        }
        return (<div></div>)
      }
}