require_relative '../initializer'

module ATM
  module Entities
    class Note < Grape::Entity
      expose :note
      expose :amount
    end
  end

  class API < Grape::API
    include ValidationHelpers

    namespace '/withdraw' do
      format :json

      params do
        build_with Grape::Extensions::Hash::ParamBuilder
        requires :amount, type: Integer, values: VALIDATE_POSITIVE_INT
      end

      post '/' do
        error!('Unauthorized', 401) unless env['HTTP_AUTHORIZATION'] == DB_CONFIG["user"]

        Note.withdraw(params[:amount])
      rescue NotEnoughMoneyException, NoNominalException => e
        error!({ error: e.message }, 403)
      end
    end

    namespace '/charge' do
      format :json

      params do
        requires :notes, type: JSON do
          Note::VALID_NOTES.each do |valid_note|
            optional valid_note.to_s.to_sym, type: Integer, values: VALIDATE_POSITIVE_INT
          end
        end
      end

      post '/' do
        error!('Unauthorized', 401) unless env['HTTP_AUTHORIZATION'] == DB_CONFIG["staff"]

        Note.charge(declared(params)[:notes])

        present Note.all, with: ATM::Entities::Note
      end
    end
  end
end
