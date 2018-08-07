import React from "react"

export default class PrincipalDetails extends React.Component {
  render() {
    return (
        <div className="card">
          <div className="card-body">
            <h3 className="card-title">test@example.com</h3>
            <form>
            <div className="form-group">
              <label htmlFor="password">Password</label>
              <input type="password" id="password" className="form-control" placeholder="Password">
              </input>
              <label htmlFor="password-repeat">Password repeat</label>
              <input type="password" id="password-repeat" className="form-control" placeholder="Password repeat">
              </input>
            </div>
            <button type="submit" className="btn btn-primary">Update</button>
            </form>
          </div>        
        </div>
       )
  }
}
