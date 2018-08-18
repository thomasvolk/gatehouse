import React from "react"
import Email from "./principal/Email"
import Password from "./principal/Password"
import Roles from "./principal/Roles"
import Dispatcher from "../dispatcher";

export default class Principal extends React.Component {
  
  callback(pid) {
    console.log("Principal" + pid)
  }

  componentDidMount() {
    Dispatcher.pricipalSelected.addObserver( this.callback )
  }

  componentWillUnmount(){
    Dispatcher.pricipalSelected.removeObserver( this.callback )
  }

  renderDetails() {
    return 
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
      </div>
  }
  
  render() {
    if(this.props.principal === undefined) {
      return (<div></div>)
    }
    return (this.renderDetails()) 
  }
}
