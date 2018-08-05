
import React from "react"
import ReactDOM from "react-dom"

class AdminApp extends React.Component {
  render() {
    return (<h1>Gateouse Administration</h1>)
  }
}

ReactDOM.render(
  <AdminApp/>,
  document.getElementById("admin-app")
)
