import React from "react"

export default class Password extends React.Component {
  render() {
    return (
      <form>
      <div className="form-group">
        <label htmlFor="password">Password</label>
        <input type="password" id="password" className="form-control" placeholder="Password">
        </input>
        <label htmlFor="password-repeat">Password repeat</label>
        <input type="password" id="password-repeat" className="form-control" placeholder="Password repeat">
        </input>
      </div>
      <button type="submit" className="btn btn-primary">Update Password</button>
      </form>
    )
  }
}
