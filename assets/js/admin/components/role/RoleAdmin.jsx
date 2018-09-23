import React from "react"
import RoleList from "./RoleList"
import Role from "./Role"
import CreateRole from "./CreateRole"
import T from 'i18n-react'

export default class RoleAdmin extends React.Component {
  constructor(props) {
    super(props)
    this.state = { createRole: false }
  }

  onCreateRole() {
    this.setState({createRole: true})
  }

  onCloseCreateRole() {
    this.setState({createRole: false})
  }

  renderRoleList() {
    return (
      <div className="container-fluid">
        <T.text tag='h2' text="roles"/>
        <div className="row">
          <div className="col-xs-4">
            <div>
              <button type="button" className="btn btn-primary"
                onClick={() => this.onCreateRole()}><T.text text="create_role"/></button>
            </div>
            <RoleList/>
          </div>
          <div className="col-xs-8">
             <Role/>
          </div>
        </div>
      </div>
    )
  }

  renderCreateRole() {
    return (
      <div>
        <CreateRole close={() => this.onCloseCreateRole()}/>
      </div>
    )
  }

  render() {
    if(this.state.createRole) {
      return this.renderCreateRole()
    }
    return this.renderRoleList()
  }
}
