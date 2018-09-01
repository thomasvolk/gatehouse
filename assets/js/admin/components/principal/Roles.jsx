import React from "react"
import Server from "../../server"
import Dispatcher from "../../dispatcher"

export default class Roles extends React.Component {

  onChange(rid, newState) {
    Server.put(`principal/${this.props.principalId}/role/${rid}`, 
      { active: newState })
    Dispatcher.principalChanged.update(this.props.principalId)
  }

  render() {
    const roles = this.props.roles
    const principalId = this.props.principalId
    return (
      <div>
        <ul className="list-group">
          {roles.map(r => <li className="list-group-item"
               key={r.id}>
            <input className="form-check-input" type="checkbox" checked={r.active} onChange={() => this.onChange(r.id, !r.active)}/>
            <label className="form-check-label">
               {r.name}
            </label>    
          </li>)}
        </ul>
      </div>
    )
  }
}
