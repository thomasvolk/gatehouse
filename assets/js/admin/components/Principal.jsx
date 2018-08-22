import React from "react"
import Email from "./principal/Email"
import Password from "./principal/Password"
import Roles from "./principal/Roles"
import server from "../server"
import Dispatcher from "../dispatcher";

export default class Principal extends React.Component {

  constructor(props) {
    super(props)
    this.state = { principal: undefined }
  }
  
  componentDidMount() {
    this.pricipalSelectedCallback = Dispatcher.pricipalSelected.addObserver((pid) => this.update(pid))
  }

  componentWillUnmount(){
    if(this.pricipalSelectedCallback) {
      Dispatcher.pricipalSelected.removeObserver( this.pricipalSelectedCallback )
    }
    this.pricipalSelectedCallback = undefined
  }

  update(principalId) {
    server.get(`/administration/api/principal/${principalId}/roles_selection_list`).then( 
      principal => {
      if(this.pricipalSelectedCallback) {
        this.setState({ principal: principal })
      }
    })
  }

  renderDetails(principal) {
    return (
      <div className="card">
        <div className="card-body">
        <div className="container-fluid">
            <div className="row">
              <div className="col-xs-8">
                <Email email={principal.email}/>
              </div>  
            </div>
          </div>
          <div className="container-fluid">
            <div className="row">
              <div className="col-xs-6">
                <Password principalId={principal.id}/>
              </div>
              <div className="col-xs-6">
                <Roles roles={principal.roles_selection_list} principalId={principal.id}/>
              </div>
            </div>
          </div>
        </div>
      </div>)
  }
  
  render() {
    const principal = this.state.principal
    if(principal === undefined) {
      return (<div></div>)
    }
    return (this.renderDetails(principal)) 
  }
}
