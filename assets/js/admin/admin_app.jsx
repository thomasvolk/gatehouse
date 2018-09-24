import ReactDOM from "react-dom"
import React from "react"
import i18n from './i18n'
import { Router, Route, Redirect, Switch } from 'react-router'
import createHashHistory from "history/createHashHistory"
import PrincipalAdmin from "./components/principal/PrincipalAdmin"
import RoleAdmin from "./components/role/RoleAdmin"
import AlertBox from "./components/AlertBox"
import { I18nextProvider } from 'react-i18next'

const history = createHashHistory({ queryKey: false })

ReactDOM.render(
  <I18nextProvider i18n={ i18n }>
    <Router history={history}>
      <div>
        <AlertBox/>
        <Switch>
        <Redirect exact path="/" to="/principal"/>
        <Route path="/principal" component={PrincipalAdmin}/>
        <Route path="/role" component={RoleAdmin}/>
        </Switch>
      </div>
    </Router>
  </I18nextProvider>,
  document.getElementById("admin-app")
)
