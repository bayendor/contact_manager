require 'rails_helper'

describe 'the company view', type: :feature do

  let(:company) { Company.create(name: 'Aperture Labs') }

  describe 'phone_numbers' do
    before(:each) do
      company.phone_numbers.create(number: '555-1234')
      company.phone_numbers.create(number: '555-5678')
      visit company_path(company)
    end

    it 'shows the phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it 'has a link to add a new phone number' do
      expect(page).to have_link('Add phone number',
        href: new_phone_number_path(contact_id: company.id, contact_type: 'Company'))
    end

    it 'adds a new phone number' do
      page.click_link('Add phone number')
      page.fill_in('Number', with: '555-8888')
      page.click_button('Create Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-8888')
    end

    it 'has links to edit phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it 'edits a phone number' do
      phone = company.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit').click
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-9191')
      expect(page).to_not have_content(old_number)
    end

    it 'has links to delete phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end

    it 'deletes a phone number' do
      phone = company.phone_numbers.first
      old_number = phone.number

      first(:link, 'delete').click
      expect(current_path).to eq(company_path(company))
      expect(page).to_not have_content(old_number)
    end
  end

  describe 'email addresses' do
    skip
    before(:each) do
      person.email_addresses.create(address: 'cave@aperture_labs.com')
      person.email_addresses.create(address: 'boss@aperture_labs.com')
      visit person_path(person)
    end

    xit 'shows the email addresses' do
      person.email_addresses.each do |email|
        expect(page).to have_content(email.address)
        expect(page).to have_selector('li', text: 'cave@aperture_labs.com')
      end
    end

    xit 'has an add email address link' do
      expect(page).to have_link('Add email address',
        href: new_email_address_path(person_id: person.id))
    end

    xit 'adds a new email address' do
      page.click_link('Add email address')
      page.fill_in('Address', with: 'rattman@aperture_labs.com')
      page.click_button('Create Email address')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('rattman@aperture_labs.com')
    end

    xit 'has links to edit email addresses' do
      person.email_addresses.each do |address|
        expect(page).to have_link('edit', href: edit_email_address_path(address))
      end
    end

    xit 'edits an email address' do
      address = person.email_addresses.first
      old_address = address.address

      first(:link, 'edit').click
      page.fill_in('Address', with: 'alice@turing.com')
      page.click_button('Update Email address')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('alice@turing.com')
      expect(page).to_not have_content(old_address)
    end

    xit 'has links to delete email addresses' do
      person.email_addresses.each do |address|
        expect(page).to have_link('delete', href: email_address_path(address))
      end
    end

    xit 'deletes an email address' do
      address = person.email_addresses.first
      old_address = address.address

      first(:link, 'delete').click
      expect(current_path).to eq(person_path(person))
      expect(page).to_not have_content(old_address)
    end
  end
end
