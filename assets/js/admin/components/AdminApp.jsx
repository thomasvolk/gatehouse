
import React from "react"
import T from 'i18n-react'
import PrincipalList from "./PrincipalList"
import CreatePrincipal from "./CreatePrincipal"
import Principal from "./Principal"
import Dispatcher from "../dispatcher";

export default class AdminApp extends React.Component {
  constructor() {
    super()
    this.dispatcher = new Dispatcher()
  }
  render() {
    return (
        <div className="container-fluid">
          <div className="row">
            <div className="col-xs-4">
              <CreatePrincipal/>
              <PrincipalList dispatcher={this.dispatcher}/>
            </div>
            <div className="col-xs-8">
              <Principal/>
            </div>
          </div>
        </div>
    )
  }
}
