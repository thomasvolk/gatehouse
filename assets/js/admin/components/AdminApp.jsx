
import React from "react"
import T from 'i18n-react'
import PrincipalList from "./PrincipalList"
import Principal from "./Principal"

export default class AdminApp extends React.Component {
  render() {
    return (
        <div className="container-fluid">
          <div className="row">
            <div className="col-xs-4">
              <PrincipalList/>
            </div>
            <div className="col-xs-8">
              <Principal/>
            </div>
          </div>
        </div>
    )
  }
}
