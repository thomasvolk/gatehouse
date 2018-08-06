
import React from "react"
import T from 'i18n-react'
import UserList from "./UserList"

export default class AdminApp extends React.Component {
  render() {
    return (
      <div>
        <T.text tag='h2' text="title"/>
        <UserList/>
      </div>
    )
  }
}
