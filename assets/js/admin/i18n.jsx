
import i18n from 'i18next'
import Backend from 'i18next-xhr-backend'
import { initReactI18next } from 'react-i18next'

i18n
  .use(Backend)
  .use(initReactI18next)
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
      wait: true,
      useSuspense: false
    }
  })

  export default i18n