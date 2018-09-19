import React from "react"
import Server from "../../../server"
import Dispatcher from "../../../dispatcher"

export default class Roles extends React.Component {

  constructor(props) {
    super(props)
  }

  onRemoveRole(rid) {
    Server.put(`principal/${this.props.principalId}/role/${rid}`, 
      { active: false }).then( response => {
      Dispatcher.principalChanged.update(this.props.principalId)
    })
  }

  onAddRole(event) {
    const rid = event.target.value
    Server.put(`principal/${this.props.principalId}/role/${rid}`, 
      { active: true }).then( response => {
        Dispatcher.principalChanged.update(this.props.principalId)
      })
  }

  render() {
    const UNSELECTED = "UNSELECTED"
    const unassignedRoles = this.props.unassignedRoles
    const roles = this.props.roles
    return (
      <div>
        <label>Roles</label>
        <ul className="list-group">
          {roles.map(r => <li className="list-group-item"
               key={r.id}>
               <span>{r.name}</span>
               <button type="button" 
                  onClick={(e) => this.onRemoveRole(r.id)}
                  className="btn btn-secondary btn-sm">x</button>    
          </li>)}
        </ul>
        <select value={UNSELECTED} onChange={(e) => this.onAddRole(e)} className="form-control form-control-sm">
        <option value={UNSELECTED}></option>
        {unassignedRoles.map(r =>
          <option key={r.id} value={r.id}>{r.name}</option>
        )}
        </select>
      </div>
    )
  }
}
