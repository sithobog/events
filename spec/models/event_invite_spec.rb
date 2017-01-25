require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user_owner) { FactoryGirl.create(:user) }
  let(:another_user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event, user: user_owner)}
  let(:another_event) { FactoryGirl.create(:event, user: user_owner)}
  let(:event_invite) { FactoryGirl.create(:event_invite, user: another_user, event: event)}

  context 'is valid' do
    it 'with all fields' do
      expect(event_invite).to be_valid
    end
  end

  context 'is invalid' do
    it 'without a event' do
      event_invite.event_id = ''
      expect(event_invite).not_to be_valid
    end

    it 'without a user' do
      event_invite.user_id = ''
      expect(event_invite).not_to be_valid
    end

    it 'allow to have multiple invites per user for different events' do
      expect { 
        EventInvite.create(user_id: another_user.id, event_id: event.id)
       }.to change(EventInvite, :count).by(1)
      expect { 
        EventInvite.create(user_id: another_user.id, event_id: another_event.id)
       }.to change(EventInvite, :count).by(1)
    end

    it 'not allow to have multiple invites per same event' do
      expect { 
        EventInvite.create(user_id: another_user.id, event_id: event.id)
       }.to change(EventInvite, :count).by(1)
      expect { 
        EventInvite.create(user_id: another_user.id, event_id: event.id)
       }.not_to change(EventInvite, :count)
    end

    it 'not allow to invite event\'s owner' do
      expect { 
        EventInvite.create(user_id: user_owner.id, event_id: event.id)
       }.not_to change(EventInvite, :count)
    end
  end

  context 'feed' do
    it 'creates feed' do
      expect { FactoryGirl.create(:event_invite, user: another_user, event: event)}.to change(Feed, :count).by(1)
      feed = Feed.last
      expect(feed.targetable_type).to eq('EventInvite')
    end
  end
end
