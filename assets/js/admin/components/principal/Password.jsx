import React from "react"
import Server from "../../server"
import Dispatcher from "../../dispatcher"

const MIN_PASSWORD_LENGTH = 8

export default class Password extends React.Component {
  
  constructor(props) {
    super(props)
    this.state = { password: "", passwordRepeat: "" }
  }
  
  updatePassword(event) {
    this.setState({password: event.target.value})
  }

  updatePasswordRepeat(event) {
    this.setState({passwordRepeat: event.target.value})
  }

  handleSubmit(event) {
    if(this.state.password == this.state.passwordRepeat 
       && this.state.password.length >= MIN_PASSWORD_LENGTH) {
      Server.put(`/administration/api/principal/${this.props.principalId}/password`, 
        { password: this.state.password })
      Dispatcher.principalChanged.update(this.props.principalId)
      document.getElementById("change-password-form").reset()
    }
    event.preventDefault()
  }

  render() {
    return (
      <form id="change-password-form" onSubmit={(e) => this.handleSubmit(e)}>
      <div className="form-group">
        <label htmlFor="password">Password</label>
        <input type="password" id="password" className="form-control" 
           placeholder="Password" onChange={(e) => this.updatePassword(e)}>
        </input>
        <label htmlFor="password-repeat">Password repeat</label>
        <input type="password" id="password-repeat" className="form-control" 
          placeholder="Password repeat" onChange={(e) => this.updatePasswordRepeat(e)}>
        </input>
      </div>
      <button type="submit" className="btn btn-primary">Update Password</button>
      </form>
    )
  }
}
