import React from "react"
import { translate } from 'react-i18next'

class ShowPassword extends React.Component {
  
  constructor(props) {
    super(props)
    this.state = { showPassword: false }
  }

  onShowPassword(showPassword) {
    this.setState({showPassword: showPassword})
  }

  onCopy(id) {
    var copyText = document.getElementById(id)
    copyText.select()
    document.execCommand("copy")
  }

  render() {
    const { t } = this.props
    const password = this.props.password
    const showPassword = this.state.showPassword
    const showPwdButtonText = showPassword ? t('hide_password') : t('show_password')
    const password_field_id = "principal_password"
    const pwd = showPassword ? <div>
        <input type="text" readOnly value={password} id={password_field_id}></input>
        <button type="button" className="btn btn-secundary"
                onClick={() => this.onCopy(password_field_id)}>copy</button>
      </div> : <div></div>

    return (
      <span>
         <button type="button" className="btn btn-primary"
                onClick={() => this.onShowPassword(!showPassword)}>{showPwdButtonText}</button>
         {pwd}
      </span>
    )
  }
}

export default translate()(ShowPassword)