
import React from "react"
import server from "./server"

export default class PrincipalList extends React.Component {

  constructor() {
    super()
    this.state = { principals: [] }
  }

  componentDidMount() {
    server.get('/administration/api/principal').then( principals => {
      this.setState({ principals: principals })
    } )
  }

  onItemClicked(principalId) {
      this.props.dispatcher.pricipalSelected(principalId)
  }

  render() {
    var principals = this.state.principals

    return (
      <div className="list-group">
          {principals.map(p => <a href="#" className="list-group-item"
               key={p.id} onClick={() => this.onItemClicked(p.id)}>{p.email}</a>)}
      </div>
       )
  }
}
