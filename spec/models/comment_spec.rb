require 'rails_helper'

RSpec.describe Event, type: :model do

  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event, user: user)}
  let(:comment) { FactoryGirl.create(:comment, event: event) }
  context 'is valid' do
    it 'with all fields' do
      expect(comment).to be_valid
    end
  end

  context 'is invalid' do
    it 'without a author' do
      comment.author = ''
      expect(comment).not_to be_valid
    end

    it 'without a content' do
      comment.content = ''
      expect(comment).not_to be_valid
    end

    it 'without event' do
      comment.event_id = nil
      expect(comment).not_to be_valid
    end

    it 'with too long author' do
      comment.author = 'a'*151
      expect(comment).not_to be_valid
    end

    it 'with too long content' do
      comment.content = 'a'*501
      expect(comment).not_to be_valid
    end
  end
end
