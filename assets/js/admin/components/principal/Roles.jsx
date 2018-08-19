import React from "react"

export default class Roles extends React.Component {
  render() {
    const roles = this.props.roles
    return (
      <div>
        <ul className="list-group">
          {roles.map(r => <li className="list-group-item"
               key={r.id}>
            <input className="form-check-input" type="checkbox"/>
            <label className="form-check-label" htmlFor="role{r.id}">
               {r.name}
            </label>    
          </li>)}
        </ul>
      </div>
    )
  }
}
