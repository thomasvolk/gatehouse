
import i18next from 'i18next'

i18next
  .init({
    interpolation: {
      escapeValue: false,
    },
    lng: 'en',
    resources: {
      en: {
        translation: {
            principals: 'Principals',
            roles: 'Roles',
            create_role: 'Create Role',
        },
      }
    }
  })

export default i18next