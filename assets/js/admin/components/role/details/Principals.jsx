import React from "react"

export default class Principals extends React.Component {
    render() {
        const principals = this.props.principals
        return (
            <div>
                <span>Principals:</span>
                <ul className="list-group">
                    {principals.map(p => <li className="list-group-item" key={p.id}>
                    {p.email}
                </li>)}
                </ul>
            </div>
        )
    }
}