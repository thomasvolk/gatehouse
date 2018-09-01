import React from "react"
import Email from "./principal/Email"
import Password from "./principal/Password"
import Roles from "./principal/Roles"
import DeletePrincipal from "./principal/DeletePrincipal"
import server from "../server"
import Dispatcher from "../dispatcher";

export default class Principal extends React.Component {

  constructor(props) {
    super(props)
    this.state = { principal: undefined }
  }
  
  componentDidMount() {
    this.principalSelectedCallback = Dispatcher.principalSelected.addObserver((pid) => this.update(pid))
    this.principalChangedCallback = Dispatcher.principalChanged.addObserver((pid) => this.update(pid))
    this.principalDeletedCallback = Dispatcher.principalDeleted.addObserver((pid) => this.setState({ principal: undefined }))
  }

  componentWillUnmount(){
    if(this.principalSelectedCallback) {
      Dispatcher.principalSelected.removeObserver( this.principalSelectedCallback )
    }
    this.principalSelectedCallback = undefined

    if(this.principalChangedCallback) {
      Dispatcher.principalChanged.removeObserver( this.principalChangedCallback )
    }
    this.principalChangedCallback = undefined
    if(this.principalDeletedCallback) {
      Dispatcher.principalDeleted.removeObserver( this.principalDeletedCallback )
    }
    this.principalDeletedCallback = undefined
  }

  update(principalId) {
    server.get(`principal/${principalId}/roles_selection_list`).then( 
      principal => {
      if(this.principalSelectedCallback) {
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
            <div className="row">
              <div className="col-xs-6">
              </div>
              <div className="col-xs-6">
                <DeletePrincipal principalId={principal.id}/>
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
