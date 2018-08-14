
import React from "react"

export default class PrincipalList extends React.Component {

  constructor() {
    super()
    this.state = { principals: [] }
  }

  fetchFromServer(url) {
    return fetch(url)
      .then(response => response.json())
      .catch(ex => {
        alert("ERROR: " + ex);
      })
  }

  componentWillMount() {
    this.fetchFromServer('/administration/principal').then( principals => {
      this.setState({ principals: principals })
    } )
  }

  render() {
    var principals = this.state.principals

    return (
      <div>
        <ul className="list-group">
          {principals.map(p => <li className="list-group-item" key={p.id} >{p.email}</li>)}
        </ul>
      </div>
       )
  }
}
