import React from "react"
import Server from "../../server"
import Dispatcher from "../../dispatcher"
import DeleteRole from "./details/DeleteRole"

export default class Role extends React.Component {

  constructor(props) {
    super(props)
    this.state = { role: undefined }
  }
  
  componentDidMount() {
    this.mounted = true
    this.roleSelectedCallback = Dispatcher.roleSelected.addObserver((rid) => this.update(rid))
    this.roleDeletedCallback = Dispatcher.roleDeleted.addObserver((pid) => this.setState({ role: undefined }))
  }

  componentWillUnmount(){
    this.mounted = false
    Dispatcher.roleSelected.removeObserver( this.roleSelectedCallback )
    Dispatcher.roleDeleted.removeObserver( this.roleDeletedCallback )
  }

  update(roleId) {
    Server.get(`role/${roleId}`).then(
      role => {
      if(this.mounted) {
        this.setState({ role: role })
      }
    }) 
  }

  renderDetails(role) {
    return (
      <div className="card">
        <div className="card-body">
          <h3 className="card-title">{role.name}</h3>
          <DeleteRole roleId={role.id}/>
        </div>
      </div>)
  }
  
  render() {
    const role = this.state.role
    if(role === undefined) {
      return (<div></div>)
    }
    return (this.renderDetails(role)) 
  }
}
