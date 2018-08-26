import React from "react"

export default class CreatePrincipal extends React.Component {
  
  onCancel() {
    this.props.onCancel()
  }
  
  render() {
    return (
       <div>
         <h2>Create Principal</h2>
         <form>
         <label htmlFor="password">Password</label>
            <input type="text" id="email" className="form-control" 
              placeholder="Email">
            </input>
            <button type="button" className="btn btn-secundary"
              onClick={() => this.onCancel()}>Cancel</button>
            <button type="submit" className="btn btn-primary">Create</button>
         </form>
       </div>
      )
  }
}
