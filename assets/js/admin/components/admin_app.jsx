
import React from "react"
import ReactDOM from "react-dom"
import T from 'i18n-react';

class AdminApp extends React.Component {
  render() {
    return (<T.text tag='h2' text="title"/>)
  }
}

ReactDOM.render(
  <AdminApp/>,
  document.getElementById("admin-app")
)
