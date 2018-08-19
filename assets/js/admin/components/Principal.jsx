import React from "react"
import Email from "./principal/Email"
import Password from "./principal/Password"
import Roles from "./principal/Roles"
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
    Dispatcher.pricipalSelected.removeObserver( this.pricipalSelectedCallback )
  }

  update(principalId) {
    this.setState({ principal: principalId })
  }

  renderDetails() {
    return (
      <div className="card">
        <div className="card-body">
        <div className="container-fluid">
            <div className="row">
              <div className="col-xs-8">
                <Email/>
              </div>  
            </div>
          </div>
          <div className="container-fluid">
            <div className="row">
              <div className="col-xs-6">
                <Password/>
              </div>
              <div className="col-xs-6">
                <Roles/>
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
    return (this.renderDetails()) 
  }
}
