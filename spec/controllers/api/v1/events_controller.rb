require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event, user: user) }
  let(:picture_64) { 'data:image/jpeg;base64,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'}
  let(:another_picture_64) { 'data:image/png;base64,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'}
  let(:picture_name) { 'cute_heart.jpg' }
  let(:updated_event) do
    FactoryGirl.attributes_for(:event, place: 'Kharkov', date: DateTime.now + 1.year,
                                       purpose: 'Another purpose', description: 'Important speach' )
  end

  context 'not authenticated user' do
    it 'shows' do
      get :show, { id: event.id }

      expect(response.status).to eq 401
    end

    it 'index' do
      get :index

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

    it 'index' do
      event
      get :index

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

  context 'unauthorizated user' do
    let(:another_user) { FactoryGirl.create(:user) }
    let(:event) { FactoryGirl.create(:event, user: another_user) }
    before(:each) do
      User.destroy_all # have to coz something wrong with token generation in spec:/
      request.headers.merge! user.create_new_auth_token
    end

    it 'shows' do
      get :show, { id: event.id }

      expect(response.status).to eq 403
    end

    it 'destroys' do
      event
      expect{ delete :destroy, id: event.id}.not_to change(Event, :count)

      expect(response.status).to eq 403
    end

    it 'updates' do
      expect{
        put :update, id: event.id, event: updated_event
        event.reload
      }.not_to change{ event.place }

      expect(response.status).to eq 403
    end
  end

  context 'invalid event data' do
    let(:event_params) { FactoryGirl.attributes_for(:event, user: user, place: nil) }
    before(:each) do
      User.destroy_all # have to coz something wrong with token generation in spec:/
      request.headers.merge! user.create_new_auth_token
    end

    it 'returns erros on create' do
      expect{ post :create, event: event_params}.not_to change(Event, :count)

      expect(response.status).to eq 422
      expect(response.body).to have_node(:errors)
      expect(response.body).to have_node(:place).including_text("can't be blank")
    end

    it 'updates' do
      expect{
        put :update, id: event.id, event: event_params
        event.reload
      }.not_to change{ event.place }

      expect(response.status).to eq 422
      expect(response.body).to have_node(:place).including_text("can't be blank")
    end
  end

  context 'upload picture' do
    let(:event_params) { FactoryGirl.attributes_for(:event, user: user) }
    let(:picture_params) { FactoryGirl}
    before(:each) do
      User.destroy_all # have to coz something wrong with token generation in spec:/
      request.headers.merge! user.create_new_auth_token
    end

    it 'create' do
      post :create, event: event_params, picture: { file_data: picture_64, file_name: picture_name }

      event = Event.last

      expect(event.picture_file_name).to eq(picture_name)
      expect(event.picture_file_size).not_to eq(nil)
      
      expect(response.status).to eq 201
    end

    it 'updates' do
      event.add_picture(another_picture_64, 'small_truck.png')
      expect{
        put :update, id: event.id, event: event_params, picture: { file_data: picture_64, file_name: picture_name }
        event.reload
      }.to change{ event.picture_file_name }

      expect(response.status).to eq 200
    end
  end

  context 'with filter params' do
    before(:each) do
      Event.destroy_all
      User.destroy_all # have to coz something wrong with token generation in spec:/
      request.headers.merge! user.create_new_auth_token
    end
    let!(:events) { FactoryGirl.create_list(:event, 10, user: user)}

    it 'index with due' do
      specific_date = Date.new(2020,10,10)
      expect(Event.count).to eq events.length

      FactoryGirl.create(:event, user: user, date: specific_date)

      get :index, due: specific_date.to_time.to_i

      suitable_events = JSON.parse(response.body)

      expect(suitable_events.length).to eq 1

      expect(response.status).to eq 200
    end

    it 'index with interval' do
      expect(Event.count).to eq events.length
      # this dates are out of interval
      specific_date_1 = DateTime.now + 15.weeks
      specific_date_2 = DateTime.now + 11.weeks

      FactoryGirl.create(:event, user: user, date: specific_date_1)
      FactoryGirl.create(:event, user: user, date: specific_date_2)

      get :index, interval: '10w'

      suitable_events = JSON.parse(response.body)

      expect(suitable_events.length).to eq events.length

      expect(response.status).to eq 200
    end
  end

  context 'hide not available events' do
    before(:each) do
      Event.destroy_all
      User.destroy_all # have to coz something wrong with token generation in spec:/
      request.headers.merge! user.create_new_auth_token
    end
    let(:another_user) { FactoryGirl.create(:user, name: 'debil') }

    it 'index hide event w/o invitation' do
      FactoryGirl.create(:event, user: user)
      FactoryGirl.create(:event, user: another_user)

      get :index

      suitable_events = JSON.parse(response.body)

      expect(suitable_events.length).to eq 1

      expect(response.status).to eq 200
    end

    it 'index show event by invitation' do
      FactoryGirl.create(:event, user: user)
      another_event = FactoryGirl.create(:event, user: another_user)
      FactoryGirl.create(:event_invite, user: user, event: another_event)

      get :index

      suitable_events = JSON.parse(response.body)

      expect(suitable_events.length).to eq 2

      expect(response.status).to eq 200
    end
  end

end
