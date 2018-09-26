import React from "react"
import ShowPassword from './detail/ShowPassword'
import Server from "../../server"
import Dispatcher from "../../dispatcher"
import { translate } from 'react-i18next'

class CreatePrincipal extends React.Component {
  
  constructor(props) {
    super(props)
    this.state = { password: undefined, email: "" }
  }
  
  onClose() {
    this.state = { password: undefined, email: "" }
    this.props.close()
  }

  updateEmail(event) {
    this.setState({email: event.target.value})
  }

  handleSubmit(event) {
    Server.post(`principal`, 
        { email: this.state.email }).then((principal) => {
          Dispatcher.principalCreated.update(principal.id)
          this.setState({password: principal.password})
        })
    event.preventDefault()
  }
  
  renderEmailForm() {
    const { t } = this.props
    return (
      <div>
        <h2>Create Principal</h2>
        <form onSubmit={(e) => this.handleSubmit(e)}>
        <label htmlFor="email">Email</label>
            <input type="text" id="email" className="form-control" 
              placeholder="Email" onChange={(e) => this.updateEmail(e)}>
            </input>
            <button type="button" className="btn btn-secundary"
              onClick={() => this.onClose()}>{t("cancel")}</button>
            <button type="submit" className="btn btn-primary">{t("create")}</button>
        </form>
      </div>
    )
  }

  renderPasswordView(password) {
    const { t } = this.props 
    return (
      <div>
         <button type="button" className="btn btn-secundary"
              onClick={() => this.onClose()}>{t("close")}</button>
         <ShowPassword password={password}/>
      </div>
    )
  }

  render() {
    const password = this.state.password
    if(password) {
      return this.renderPasswordView(password)
    }
    else {
      return this.renderEmailForm()
    }
  }
}

export default translate()(CreatePrincipal)