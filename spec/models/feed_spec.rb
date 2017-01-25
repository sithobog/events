require 'rails_helper'

RSpec.describe Feed, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:another_user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event, user: user) }
  let(:comment) { FactoryGirl.create(:comment, event: event) }
  let(:event_invite) { FactoryGirl.create(:event_invite, user: another_user, event: event) }

  let(:feed) { FactoryGirl.create(:feed, targetable: comment, user: user) }
  context 'is valid' do
    it 'with all fields' do
      expect(feed).to be_valid
    end
  end

  context 'is invalid' do
    it 'without a use_id' do
      feed.user_id = nil
      expect(feed).not_to be_valid
    end

    it 'without a message' do
      feed.message = ''
      expect(feed).not_to be_valid
    end

    it 'without a targetable_id' do
      feed.targetable_id = ''
      expect(feed).not_to be_valid
    end

    it 'without a targetable_type' do
      feed.targetable_type = ''
      expect(feed).not_to be_valid
    end

    it 'with too long message' do
      feed.message = 'a'*251
      expect(feed).not_to be_valid
    end
  end
end
