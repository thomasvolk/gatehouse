import React from "react"
import { withTranslation } from 'react-i18next'

class Principals extends React.Component {
    render() {
        const { t } = this.props
        const principals = this.props.principals
        return (
            <div>
                <span>{t('principals')}:</span>
                <ul className="list-group">
                    {principals.map(p => <li className="list-group-item" key={p.id}>
                    {p.email}
                </li>)}
                </ul>
            </div>
        )
    }
}

export default withTranslation()(Principals)