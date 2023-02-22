require 'swagger_helper'

describe 'Users' do
  path '/api/v1/users' do
    get 'List users' do
      tags 'Users'
      security [Bearer: []]
      consumes 'application/json'
      response '200', 'session created' do
        schema type: :object,
        properties: {
          users: [{
            id: { type: :string },
            name: { type: :string },
            level_english: { type: :string },
            technical_knowledge: { type: :string },
            email: { type: :string },
            created_at: { type: :string },
            roles: [
              {
                role: { type: :string }
              }
            ]
          }]
        }
        run_test!
      end

      response '422', 'Unprocessable entity' do
        let(:error) {
          {
            error: {
              code: 401,
              status: "unprocessable_entity",
              resource: "users",
              message: "La solicitud estaba bien formada, pero no se pudo seguir debido a errores semánticos.",
              details: {}
            }
          }
        }
        run_test!
      end
    end
  end
end