import React from "react"
import PasswordUpdate from "./PasswordUpdate"
import RolesSelector from "./RolesSelector"

export default class PrincipalDetails extends React.Component {
  render() {
    return (
        <div className="card">
          <div className="card-body">
            <h3 className="card-title">test@example.com</h3>
            <PasswordUpdate/>
            <RolesSelector/>
          </div>
        </div>
       )
  }
}
