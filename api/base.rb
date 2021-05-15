require 'grape'

module Twitter
  class API < Grape::API
    version 'v1', using: :header, vendor: 'twitter'
    format :json
    prefix :api

    route :post, 'withdraw' do

    end

    route :post, 'load' do

    end

  end
end
