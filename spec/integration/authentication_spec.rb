require 'swagger_helper'

describe 'Authentication' do
  path '/api/v1/login' do
    post 'Create session' do
      tags 'Authentication'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            properties: {
              email: { type: :string, example: 'superuser@mind.com' },
              password: { type: :string, example: 'password' }
            }
          },
        },
        required: [ 'email', 'password' ]
      }
      response '200', 'session created' do
        let(:user) { 'Sesión iniciada.' }
        run_test!
      end

      response '401', 'Unauthorized request' do
        let(:error) {
          {
            error: {
              code: 401,
              status: "unauthorized",
              resource: "authentication",
              message: "El servidor no puede proporcionar acceso a la recurso solicitado porque no ha proporcionado las credenciales de acceso válidas o no tiene permiso para acceder.",
              details: {}
            }
          }
        }
        run_test!
      end
    end
  end


  path '/api/v1/logout' do
    post 'Destroy session' do
      tags 'Authentication'
      consumes 'application/json'
      response '204', 'no content' do
        run_test!
      end

      response '401', 'Unauthorized request' do
        let(:error) {
          {
            error: {
              code: 401,
              status: "unauthorized",
              resource: "authentication",
              message: "El servidor no puede proporcionar acceso a la recurso solicitado porque no ha proporcionado las credenciales de acceso válidas o no tiene permiso para acceder.",
              details: {}
            }
          }
        }
        run_test!
      end
    end
  end
end  