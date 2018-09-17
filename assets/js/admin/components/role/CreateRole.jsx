import React from "react"
import Server from "../../server"
import Dispatcher from "../../dispatcher"

export default class CreateRole extends React.Component {
  
  constructor(props) {
    super(props)
    this.state = { name: "" }
  }
  
  onCancel() {
    this.props.close()
  }

  updateName(event) {
    this.setState({name: event.target.value})
  }

  handleSubmit(event) {
    Server.post(`role`, 
        { name: this.state.name }).then((role) => {
          Dispatcher.rolesUpdated.update(role.id)
          this.props.close()
        })
    event.preventDefault();
  }
  
  render() {
    return (
      <div>
        <h2>Create Role</h2>
        <form onSubmit={(e) => this.handleSubmit(e)}>
        <label htmlFor="name">Name</label>
            <input type="text" id="name" className="form-control" 
              placeholder="Name" onChange={(e) => this.updateName(e)}>
            </input>
            <button type="button" className="btn btn-secundary"
              onClick={() => this.onCancel()}>Cancel</button>
            <button type="submit" className="btn btn-primary">Create</button>
        </form>
      </div>
    )
  }
}
