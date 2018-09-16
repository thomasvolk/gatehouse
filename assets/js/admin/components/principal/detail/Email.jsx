import React from "react"

export default class Email extends React.Component {
  render() {
    const email = this.props.email
    return (
       <h3 className="card-title">{email}</h3>
    )
  }
}
