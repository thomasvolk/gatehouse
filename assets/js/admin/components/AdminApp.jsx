
import React from "react"
import T from 'i18n-react'
import PrincipalList from "./PrincipalList"
import CreatePrincipal from "./CreatePrincipal"
import Principal from "./Principal"

export default class AdminApp extends React.Component {
  constructor(props) {
    super(props)
    this.state = { createPrincipal: false }
  }

  onCreatePrincipal() {
    this.setState({createPrincipal: true})
  }

  onCancelCreatePrincipal() {
    this.setState({createPrincipal: false})
  }

  renderPrincipalList() {
    return (
        <div className="container-fluid">
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
      <CreatePrincipal onCancel={() => this.onCancelCreatePrincipal()}/>
    )
  }

  render() {
    if(this.state.createPrincipal) {
      return this.renderCreatePrincipal()
    }
    return this.renderPrincipalList()
  }
}
