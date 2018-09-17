import React from "react"
import Server from "../../server"
import Dispatcher from "../../dispatcher"

export default class Role extends React.Component {

  constructor(props) {
    super(props)
    this.state = { role: undefined }
  }
  
  componentDidMount() {
    this.mounted = true
    this.roleSelectedCallback = Dispatcher.roleSelected.addObserver((rid) => this.update(rid))
  }

  componentWillUnmount(){
    this.mounted = false
    Dispatcher.roleSelected.removeObserver( this.roleSelectedCallback )
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
