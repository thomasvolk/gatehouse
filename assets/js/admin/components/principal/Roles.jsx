import React from "react"

export default class Roles extends React.Component {

  onChange(rid, newState) {
    console.log(`rid=${rid} state=${newState}`)
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
