import ReactDOM from "react-dom"
import React from "react"
import "./i18n"
import { Router, Route, Redirect } from 'react-router'
import createHashHistory from "history/createHashHistory"
import PrincipalAdmin from "./components/principal/PrincipalAdmin"

const history = createHashHistory({ queryKey: false })

ReactDOM.render(
  <Router history={history}>
    <div>
      <Route path="/principal" component={PrincipalAdmin}/>
    </div>
  </Router>,
  document.getElementById("admin-app")
)
