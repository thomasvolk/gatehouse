import React from "react"
import Server from "../../../server"
import Dispatcher from "../../../dispatcher"

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
    Server.put(`principal/${this.props.principalId}/password`, 
      { password: this.state.password,
        passwordRepeat: this.state.passwordRepeat }).then( response => {
          if(response) {
            Dispatcher.principalChanged.update(this.props.principalId)
            this.setState({password: "", passwordRepeat: ""})
          }
    })
    event.preventDefault()
  }

  render() {
    const password = this.state.password
    const passwordRepeat = this.state.passwordRepeat
    return (
      <form id="change-password-form" onSubmit={(e) => this.handleSubmit(e)}>
        <div className="form-group">
          <label htmlFor="password">Password</label>
          <input type="password" id="password" className="form-control" value={password}
            placeholder="New Password" onChange={(e) => this.updatePassword(e)}>
          </input>
          <label htmlFor="password-repeat">Password repeat</label>
          <input type="password" id="password-repeat" className="form-control" value={passwordRepeat}
            placeholder="New Password repeat" onChange={(e) => this.updatePasswordRepeat(e)}>
          </input>
        </div>
        <button type="submit" className="btn btn-primary">Change Password</button>
      </form>
    )
  }
}
