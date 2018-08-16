
import React from "react"
import server from "./server"

export default class PrincipalList extends React.Component {

  constructor() {
    super()
    this.state = { principals: [] }
  }

  componentDidMount() {
    server.get('/administration/principal').then( principals => {
      this.setState({ principals: principals })
    } )
  }

  selectPrincipal(principalId) {
    console.log(principalId)
  }

  render() {
    var principals = this.state.principals

    return (
      <div className="list-group">
          {principals.map(p => <a href="#" className="list-group-item" key={p.id} onClick={() => this.selectPrincipal(p.id)}>{p.email}</a>)}
      </div>
       )
  }
}
