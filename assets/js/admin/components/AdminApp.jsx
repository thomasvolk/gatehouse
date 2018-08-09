
import React from "react"
import T from 'i18n-react'
import PrincipalList from "./PrincipalList"
import PrincipalDetails from "./PrincipalDetails"

export default class AdminApp extends React.Component {
  render() {
    return (
        <div className="container-fluid">
          <div className="row">
            <div className="col-xs-4">
              <PrincipalList/>
            </div>
            <div className="col-xs-8">
              <PrincipalDetails/>
            </div>
          </div>
        </div>
    )
  }
}
