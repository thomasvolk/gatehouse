import React from "react"
import Server from "../../../server"
import Dispatcher from "../../../dispatcher"

export default class DeleteRole extends React.Component {
  
    constructor(props) {
      super(props)
      this.state = { deleteRequest : false }
    }
    
    onCancel() {
      this.setState({ deleteRequest : false })
    }
  
    onRequest() {
      this.setState({ deleteRequest : true })
    }

    onCommit() {
      Server.del(`role/${this.props.roleId}`).then((response) => {
        this.setState({ deleteRequest : false })
        Dispatcher.roleDeleted.update(this.props.roleId)
      })
    }
    
    render() {
      const deleteRequest = this.state.deleteRequest
      if(deleteRequest) {
        return (<div>
          <button type="button" className="btn btn-secundary"
            onClick={() => this.onCancel()}>Cancel</button>
          <button type="button" className="btn btn-primary"
            onClick={() => this.onCommit()}>Yes Delete</button>
        </div>)
      }
      else {
        return (<div>
          <a href="#/role" className="btn btn-secundary"
            onClick={() => this.onRequest()}>Delete Role</a>
        </div>)
      }
    }
  }
  