
import React from "react"
import ReactDOM from "react-dom"

class UserList extends React.Component {
  render() {
    return (<div>this is the user list</div>)
  }
}

ReactDOM.render(
  <UserList/>,
  document.getElementById("user-list")
)
