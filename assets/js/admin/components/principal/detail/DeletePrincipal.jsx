import React from "react"
import Server from "../../../server"
import Dispatcher from "../../../dispatcher"
import { withTranslation } from 'react-i18next'

class DeletePrincipal extends React.Component {
  
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
      Server.del(`principal/${this.props.principalId}`).then((response) => {
        this.setState({ deleteRequest : false })
        Dispatcher.principalDeleted.update(this.props.principalId)
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
          <a href="#/principal" className="btn btn-secundary"
            onClick={() => this.onRequest()}>{t('delete_principal')}</a>
        </div>)
      }
    }
  }
  
  export default withTranslation()(DeletePrincipal)