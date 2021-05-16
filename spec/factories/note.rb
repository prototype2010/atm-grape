require_relative '../../initializer'

FactoryBot.define do
  factory :note do
    note { 1 }
    amount { 10 }
  end
end
