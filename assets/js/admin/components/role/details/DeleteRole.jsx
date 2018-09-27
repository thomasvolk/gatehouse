import React from "react"
import Server from "../../../server"
import Dispatcher from "../../../dispatcher"
import { translate } from 'react-i18next'

class DeleteRole extends React.Component {
  
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
      const { t } = this.props
      const deleteRequest = this.state.deleteRequest
      if(deleteRequest) {
        return (<div>
          <button type="button" className="btn btn-secundary"
            onClick={() => this.onCancel()}>{t('cancel')}</button>
          <button type="button" className="btn btn-primary"
            onClick={() => this.onCommit()}>{t('yes_delete')}</button>
        </div>)
      }
      else {
        return (<div>
          <a href="#/role" className="btn btn-secundary"
            onClick={() => this.onRequest()}>{t('delete_role')}</a>
        </div>)
      }
    }
}

export default translate()(DeleteRole)