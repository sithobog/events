require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event, user: user)}
  context 'is valid' do
    it 'with all fields' do
      expect(event).to be_valid
    end
  end

  context 'is invalid' do
    it 'without a place' do
      event.place = ''
      expect(event).not_to be_valid
    end

    it 'without a date' do
      event.date = ''
      expect(event).not_to be_valid
    end

    it 'without a purpose' do
      event.purpose = ''
      expect(event).not_to be_valid
    end

    it 'without a description' do
      event.description = ''
      expect(event).not_to be_valid
    end

    it 'without user' do
      event.user_id = nil
      expect(event).not_to be_valid
    end

    it 'with date in past' do
      event.date = DateTime.now - 1.hour
      expect(event).not_to be_valid
    end

    it 'with too long place' do
      event.place = 'a'*151
      expect(event).not_to be_valid
    end

    it 'with too long purpose' do
      event.purpose = 'a'*151
      expect(event).not_to be_valid
    end

    it 'with too long description' do
      event.description = 'a'*501
      expect(event).not_to be_valid
    end
  end
end
