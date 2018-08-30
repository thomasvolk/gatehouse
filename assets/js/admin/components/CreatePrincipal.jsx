import React from "react"
import Server from "../server"
import Dispatcher from "../dispatcher"
import AlertBox from "./AlertBox"

export default class CreatePrincipal extends React.Component {
  
  constructor(props) {
    super(props)
    this.state = { email: "", errorMessage: undefined }
  }
  
  onCancel() {
    this.props.close()
  }

  updateEmail(event) {
    this.setState({email: event.target.value})
  }

  handleSubmit(event) {
    Server.post(`/administration/api/principal`, 
        { email: this.state.email }).then((principal) => {
          Dispatcher.principalCreated.update(principal.id)
          this.props.close()
        }).catch((err) => {
          err.json().then( errorMessage => this.setState({errorMessage: errorMessage.error}) )
        })
    event.preventDefault();
  }
  
  render() {
    const errorMessage = this.state.errorMessage
    return (
      <div>
        <AlertBox errorMessage={errorMessage}/>
        <div>
          <h2>Create Principal</h2>
          <form onSubmit={(e) => this.handleSubmit(e)}>
          <label htmlFor="password">Password</label>
              <input type="text" id="email" className="form-control" 
                placeholder="Email" onChange={(e) => this.updateEmail(e)}>
              </input>
              <button type="button" className="btn btn-secundary"
                onClick={() => this.onCancel()}>Cancel</button>
              <button type="submit" className="btn btn-primary">Create</button>
          </form>
        </div>
       </div>
      )
  }
}
