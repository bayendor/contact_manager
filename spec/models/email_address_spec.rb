require 'rails_helper'

RSpec.describe EmailAddress, :type => :model do
  let(:person) { Person.create(first_name: 'Cave', last_name: 'Johnson') }
  let(:email_address) do
    EmailAddress.new(address: 'cave@aperture.labs', contact_id: 1, contact_type: 'Person')
  end

  it 'is valid' do
    expect(email_address).to be_valid
  end

  it 'is invalid without an address' do
    email_address.address = nil
    expect(email_address).to_not be_valid
  end

  it 'must have a reference to a contact' do
    email_address.contact_id = nil
    expect(email_address).not_to be_valid
  end

  it 'is associated with a contact' do
    expect(email_address).to respond_to(:contact)
  end
end
