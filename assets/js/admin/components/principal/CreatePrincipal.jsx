import React from "react"
import Server from "../../server"
import Dispatcher from "../../dispatcher"

export default class CreatePrincipal extends React.Component {
  
  constructor(props) {
    super(props)
    this.state = { password: undefined, showPassword: false, email: "" }
  }
  
  onClose() {
    this.setState({ password: undefined })
    this.props.close()
  }

  updateEmail(event) {
    this.setState({email: event.target.value, showPassword: false})
  }

  handleSubmit(event) {
    Server.post(`principal`, 
        { email: this.state.email }).then((principal) => {
          Dispatcher.principalCreated.update(principal.id)
          this.setState({password: principal.password})
        })
    event.preventDefault()
  }

  onShowPassword(showPassword) {
    this.setState({showPassword: showPassword})
  }

  onCopy(id) {
    var copyText = document.getElementById(id)
    copyText.select()
    document.execCommand("copy")
  }
  
  renderEmailForm() {
    return (
      <div>
        <h2>Create Principal</h2>
        <form onSubmit={(e) => this.handleSubmit(e)}>
        <label htmlFor="email">Email</label>
            <input type="text" id="email" className="form-control" 
              placeholder="Email" onChange={(e) => this.updateEmail(e)}>
            </input>
            <button type="button" className="btn btn-secundary"
              onClick={() => this.onClose()}>Cancel</button>
            <button type="submit" className="btn btn-primary">Create</button>
        </form>
      </div>
    )
  }

  renderPasswordView(showPassword, password) {
    const showPwdButtonText = showPassword ? "Hide password" : "Show password"
    const password_field_id = "principal_password"
    const pwd = showPassword ? <div>
        <input type="text" readOnly value={password} id={password_field_id}></input>
        <button type="button" className="btn btn-secundary"
                onClick={() => this.onCopy(password_field_id)}>copy</button>
      </div> : <div></div>

    return (
      <div>
         <button type="button" className="btn btn-secundary"
              onClick={() => this.onClose()}>Close</button>
         <button type="button" className="btn btn-primary"
                onClick={() => this.onShowPassword(!showPassword)}>{showPwdButtonText}</button>
         {pwd}
      </div>
    )
  }

  render() {
    const password = this.state.password
    const showPassword = this.state.showPassword
    if(password) {
      return this.renderPasswordView(showPassword, password)
    }
    else {
      return this.renderEmailForm()
    }
  }
}
