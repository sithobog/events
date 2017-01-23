require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event, user: user) }
  let(:updated_event) do 
    FactoryGirl.attributes_for(:event, place: 'Kharkov', date: DateTime.now + 1.year,
                                       purpose: 'Another purpose', description: 'Important speach' )
  end

  context 'not authenticated user' do
    it 'shows' do

      get :show, { id: event.id }

      expect(response.status).to eq 401
    end

    it 'creates' do
      expect{ post :create, event: updated_event}.not_to change(Event, :count)

      expect(response.status).to eq 401
    end

    it 'destroys' do
      event
      expect{ delete :destroy, id: event.id}.not_to change(Event, :count)

      expect(response.status).to eq 401
    end

    it 'updates' do
      expect{
        put :update, id: event.id, event: updated_event
        event.reload
      }.to change{ event.updated_at }

      expect(response.status).to eq 401
    end
  end

  context 'authenticated user' do
    before(:each) do
      User.destroy_all # have to coz something wrong with token generation in spec:/
      request.headers.merge! user.create_new_auth_token 
    end

    it 'shows' do

      get :show, { id: event.id }

      expect(response.status).to eq 200
    end

    it 'creates' do
      expect{ post :create, event: updated_event}.to change(Event, :count).by(1)

      expect(response.status).to eq 201
    end

    it 'destroys' do
      event
      expect{ delete :destroy, id: event.id}.to change(Event, :count).by(-1)

      expect(response.status).to eq 204
    end

    it 'updates' do
      expect{
        put :update, id: event.id, event: updated_event
        event.reload
      }.to change{ event.updated_at }

      expect(response.status).to eq 200
      expect(event.place).to eq(updated_event[:place])
      expect(event.purpose).to eq(updated_event[:purpose])
      expect(event.description).to eq(updated_event[:description])
    end
  end
end
