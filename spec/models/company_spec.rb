require 'rails_helper'

RSpec.describe Company, :type => :model do
  let(:company) do
    Company.new(name: 'Aperture Labs')
  end

  it 'is valid' do
    expect(company).to be_valid
  end

  it 'is invalid without a name' do
    company.name = nil
    expect(company).to_not be_valid
  end

  it 'has an array of phone numbers' do
    expect(company.phone_numbers).to eq([])
  end

  it 'responds with its phone numbers after they are created' do
    phone_number = company.phone_numbers.build(number: '333-4444')
    expect(phone_number.number).to eq('333-4444')
  end

  it 'has an array of email addresses' do
    expect(company.email_addresses).to eq([])
  end

  it 'responds with its created email addresses' do
    email_address = company.email_addresses.build(address: 'me@example.com')
    expect(email_address.address).to eq ('me@example.com')
  end

  it "converts to a string with company name" do
    expect(company.to_s).to eq "Aperture Labs"
  end
end
