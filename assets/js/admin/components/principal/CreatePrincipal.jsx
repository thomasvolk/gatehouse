import React from "react"
import Server from "../../server"
import Dispatcher from "../../dispatcher"

export default class CreatePrincipal extends React.Component {
  
  constructor(props) {
    super(props)
    this.state = { email: "" }
  }
  
  onCancel() {
    this.props.close()
  }

  updateEmail(event) {
    this.setState({email: event.target.value})
  }

  handleSubmit(event) {
    Server.post(`principal`, 
        { email: this.state.email }).then((principal) => {
          Dispatcher.principalCreated.update(principal.id)
          this.props.close()
        }).then((response) => event.preventDefault() )
  }
  
  render() {
    return (
      <div>
        <h2>Create Principal</h2>
        <form onSubmit={(e) => this.handleSubmit(e)}>
        <label htmlFor="email">Email</label>
            <input type="text" id="email" className="form-control" 
              placeholder="Email" onChange={(e) => this.updateEmail(e)}>
            </input>
            <button type="button" className="btn btn-secundary"
              onClick={() => this.onCancel()}>Cancel</button>
            <button type="submit" className="btn btn-primary">Create</button>
        </form>
      </div>
    )
  }
}
