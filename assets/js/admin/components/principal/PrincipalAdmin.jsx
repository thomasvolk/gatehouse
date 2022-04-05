import React from "react"
import PrincipalList from "./PrincipalList"
import CreatePrincipal from "./CreatePrincipal"
import Principal from "./Principal"
import { withTranslation } from 'react-i18next'

class PrincipalAdmin extends React.Component {
  constructor(props) {
    super(props)
    this.state = { createPrincipal: false }
  }

  onCreatePrincipal() {
    this.setState({createPrincipal: true})
  }

  onCloseCreatePrincipal() {
    this.setState({createPrincipal: false})
  }

  renderPrincipalList() {
    const { t } = this.props 
    return (
      <div className="container-fluid">
        <h2>{t('principals')}</h2>
        <div className="row">
          <div className="col-xs-4">
            <div>
              <button type="button" className="btn btn-primary"
                onClick={() => this.onCreatePrincipal()}>{t('create_principal')}</button>
            </div>
            <PrincipalList/>
          </div>
          <div className="col-xs-8">
            <Principal/>
          </div>
        </div>
      </div>
    )
  }

  renderCreatePrincipal() {
    return (
      <div>
        <CreatePrincipal close={() => this.onCloseCreatePrincipal()}/>
      </div>
    )
  }

  render() {
    if(this.state.createPrincipal) {
      return this.renderCreatePrincipal()
    }
    return this.renderPrincipalList()
  }
}

export default withTranslation()(PrincipalAdmin)