
import React from "react"
import server from "../server"
import Dispatcher from "../dispatcher";

export default class PrincipalList extends React.Component {

  constructor(props) {
    super(props)
    this.state = { principals: [] }
  }

  componentDidMount() {
    this.mounted = true;
    server.get('/administration/api/principal').then( principals => {
      if(this.mounted) {
        this.setState({ principals: principals })
      }
    })
  }

  componentWillUnmount(){
    this.mounted = false;
  }

  onItemClicked(principalId) {
    Dispatcher.pricipalSelected.update(principalId)
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
