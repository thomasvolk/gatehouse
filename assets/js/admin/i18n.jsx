
import i18n from 'i18next'
import Backend from 'i18next-xhr-backend'
import { reactI18nextModule } from 'react-i18next'

i18n
  .use(Backend)
  .use(reactI18nextModule)
  .init({
    fallbackLng: 'en',
    ns: ['translation'],
    defaultNS: 'translation',
    interpolation: {
      escapeValue: false,
    },
    backend: {
        loadPath: '/api/admin/locale/{{lng}}/{{ns}}'
    },
    react: {
      wait: true
    }
  })

  export default i18n