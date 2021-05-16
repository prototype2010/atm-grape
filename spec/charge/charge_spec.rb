require_relative '../../initializer'

RSpec.describe 'Charge' do
  def app
    Rack::Builder.parse_file('config.ru').first
  end

  context 'charged successfully for the given amount' do
    it do
      post('/charge', { notes: { '1' => 1, '2' => 2 } }, {"HTTP_AUTHORIZATION" => DB_CONFIG["staff"]})
      expect(JSON.parse(last_response.body)).to eq([{ 'amount' => 1, 'note' => 1 },
                                                    { 'amount' => 2, 'note' => 2 }])
    end

    it do
      post('/charge', { notes: { '1' => 50, '2' => 25, '100' => 50 } }, {"HTTP_AUTHORIZATION" => DB_CONFIG["staff"]})
      expect(JSON.parse(last_response.body)).to eq([{"amount"=>50, "note"=>1}, {"amount"=>25, "note"=>2}])
    end
  end

  context 'unathorized' do
    it 'unathorized operation' do
      post('/charge', { notes: { '1' => 50, '2' => 25, '100' => 50 } })

      expect(last_response.status).to be(401)
      expect(JSON.parse(last_response.body)).to eq({ 'error' => 'Unauthorized' })
    end
  end

  context 'able to withdraw after charge' do
    it do
      post('/charge', { notes: { '1' => 20 } }, {"HTTP_AUTHORIZATION" => DB_CONFIG["staff"]})
      post('/withdraw', { amount: 20 }, {"HTTP_AUTHORIZATION" => DB_CONFIG["user"]})

      expect(JSON.parse(last_response.body)).to eq({ '1' => 20 })
    end
  end
end
