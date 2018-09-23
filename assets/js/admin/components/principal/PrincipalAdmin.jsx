import React from "react"
import i18n from '../../i18n'
import PrincipalList from "./PrincipalList"
import CreatePrincipal from "./CreatePrincipal"
import Principal from "./Principal"

export default class PrincipalAdmin extends React.Component {
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
    return (
      <div className="container-fluid">
        <h2>{i18n.t('principals')}</h2>
        <div className="row">
          <div className="col-xs-4">
            <div>
              <button type="button" className="btn btn-primary"
                onClick={() => this.onCreatePrincipal()}>Create Principal</button>
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
