import React from "react"

export default class Roles extends React.Component {
  render() {
    return (
      <div>
        <ul className="list-group">
          <li className="list-group-item">
            <input className="form-check-input" type="checkbox"/>
            <label className="form-check-label" htmlFor="defaultCheck1">
              GatehouseAdmin
            </label>
          </li>
          <li className="list-group-item">
            <input className="form-check-input" type="checkbox"/>
            <label className="form-check-label" htmlFor="defaultCheck1">
              Foo
            </label>
          </li>
          <li className="list-group-item">
            <input className="form-check-input" type="checkbox"/>
            <label className="form-check-label" htmlFor="defaultCheck1">
              Bar
            </label>
            </li>
        </ul>
      </div>
    )
  }
}
