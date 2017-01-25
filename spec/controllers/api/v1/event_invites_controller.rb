require 'rails_helper'

RSpec.describe Api::V1::EventInvitesController, type: :controller do

  let(:user_owner) { FactoryGirl.create(:user) }
  let(:another_user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event, user: user_owner)}
  let(:valid_params) { { user_id: another_user.id } }

  context 'not authenticated user' do
    it 'creates' do
      expect{ post :create, event_invite: valid_params, event_id: event.id }.not_to change(EventInvite, :count)

      expect(response.status).to eq 401
    end
  end

  context 'authenticated user' do
    before(:each) do
      User.destroy_all # have to coz something wrong with token generation in spec:/
      request.headers.merge! user_owner.create_new_auth_token
    end
    it 'creates' do
      expect{ post :create, event_invite: valid_params, event_id: event.id }.to change(EventInvite, :count).by(1)

      expect(response.status).to eq 201
    end
  end

  context 'invalid event data' do
    let(:invalid_params) { { user_id: nil } }
    before(:each) do
      User.destroy_all # have to coz something wrong with token generation in spec:/
      request.headers.merge! user_owner.create_new_auth_token
    end
    it 'returns errors on create' do
      expect{ post :create, event_invite: invalid_params, event_id: event.id }.not_to change(EventInvite, :count)

      expect(response.status).to eq 422
      expect(response.body).to have_node(:errors)
      expect(response.body).to have_node(:user_id).including_text("can't be blank")
    end
  end
end
