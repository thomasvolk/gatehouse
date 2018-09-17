
import React from "react"
import server from "../../server"
import Dispatcher from "../../dispatcher"

export default class RoleList extends React.Component {

  constructor(props) {
    super(props)
    this.state = { roles: [] }
  }

  loadList() {
    server.get('role').then( roles => {
      if(this.mounted) {
        this.setState({ roles: roles })
      }
    })
  }

  componentDidMount() {
    this.mounted = true
    this.loadList()
    this.rolesUpdatedCallback = Dispatcher.rolesUpdated.addObserver(() => this.loadList())
  }

  componentWillUnmount(){
    this.mounted = false
    Dispatcher.rolesUpdated.removeObserver(this.rolesUpdatedCallback)
  }

  onItemClicked(roleId) {
    Dispatcher.roleSelected.update(roleId)
  }

  render() {
    var roles = this.state.roles

    return (
      <div className="list-group">
          {roles.map(r => <a href="#/role" className="list-group-item"
               key={r.id} onClick={() => this.onItemClicked(r.id)}>{r.name}</a>)}
      </div>
       )
  }
}
