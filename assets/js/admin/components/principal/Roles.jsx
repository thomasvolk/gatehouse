import React from "react"
import Server from "../../server"
import Dispatcher from "../../dispatcher"

export default class Roles extends React.Component {

  constructor(props) {
    super(props)
    this.state = { roles: [] }
  }

  componentDidMount() {
    this.mounted = true;
    this.loadRoles()
  }

  loadRoles() {
    Server.get('role').then( roles => {
      if(this.mounted) {
        this.setState({ roles: roles })
      }
    })
  }

  componentWillUnmount(){
    this.mounted = false;
  }

  onRemoveRole(rid) {
    Server.put(`principal/${this.props.principalId}/role/${rid}`, 
      { active: false })
    Dispatcher.principalChanged.update(this.props.principalId)
  }

  onAddRole(event) {
    const rid = event.target.value
    Server.put(`principal/${this.props.principalId}/role/${rid}`, 
      { active: true })
    Dispatcher.principalChanged.update(this.props.principalId)
  }

  render() {
    const UNSELECTED = "UNSELECTED"
    const allRoles = this.state.roles
    const roles = this.props.roles
    const principalId = this.props.principalId
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
        {allRoles.map(r =>
          <option key={r.id} value={r.id}>{r.name}</option>
        )}
        </select>
      </div>
    )
  }
}
