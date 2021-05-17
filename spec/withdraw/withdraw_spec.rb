require_relative '../../initializer'

RSpec.describe 'Withdraw' do
  def app
    Rack::Builder.parse_file('config.ru').first
  end

  before(:each) do
    FactoryBot.create(:note, note: 1)
    FactoryBot.create(:note, note: 2)
    FactoryBot.create(:note, note: 5)
    FactoryBot.create(:note, note: 10)
    FactoryBot.create(:note, note: 50)
  end

  context 'enough money' do
    it 'should be single note 1' do
      post('/withdraw', { amount: 1 }, {"HTTP_AUTHORIZATION" => DB_CONFIG["user"]})
      expect(JSON.parse(last_response.body)).to eq({ '1' => 1 })
    end

    it 'should be single note 2' do
      post('/withdraw', { amount: 2 }, {"HTTP_AUTHORIZATION" => DB_CONFIG["user"]})
      expect(JSON.parse(last_response.body)).to eq({ '2' => 1 })
    end

    it 'should be single note 5' do
      post('/withdraw', { amount: 5 }, {"HTTP_AUTHORIZATION" => DB_CONFIG["user"]})
      expect(JSON.parse(last_response.body)).to eq({ '5' => 1 })
    end

    it 'should be single note 10' do
      post('/withdraw', { amount: 10 }, {"HTTP_AUTHORIZATION" => DB_CONFIG["user"]})
      expect(JSON.parse(last_response.body)).to eq({ '10' => 1 })
    end

    it 'should be single note 50' do
      post('/withdraw', { amount: 50 }, {"HTTP_AUTHORIZATION" => DB_CONFIG["user"]})
      expect(JSON.parse(last_response.body)).to eq({ '50' => 1 })
    end

    it 'should be single note 100' do
      post('/withdraw', { amount: 100 }, {"HTTP_AUTHORIZATION" => DB_CONFIG["user"]})
      expect(JSON.parse(last_response.body)).to eq({"50"=>2})
    end

    it 'should count 269 correctly' do
      post('/withdraw', { amount: 269 }, {"HTTP_AUTHORIZATION" => DB_CONFIG["user"]})
      expect(JSON.parse(last_response.body)).to eq({"10"=>1, "2"=>2, "5"=>1, "50"=>5})
    end

    it 'should count 266 correctly' do
      post('/withdraw', { amount: 266 }, {"HTTP_AUTHORIZATION" => DB_CONFIG["user"]})
      expect(JSON.parse(last_response.body)).to eq({"1"=>1, "10"=>1, "5"=>1, "50"=>5})
    end
  end

  context 'unathorized' do
    it 'unathorized operation' do
      post('/withdraw', { amount: 1 })

      expect(last_response.status).to be(401)
      expect(JSON.parse(last_response.body)).to eq({ 'error' => 'Unauthorized' })
    end
  end

  context 'not enough money' do
    it 'should count correctly' do
      post('/withdraw', { amount: 77_777 }, {"HTTP_AUTHORIZATION" => DB_CONFIG["user"]})

      expect(last_response.status).to be(403)
      expect(JSON.parse(last_response.body)).to eq({ 'error' => 'Not enough money' })
    end
  end
end
