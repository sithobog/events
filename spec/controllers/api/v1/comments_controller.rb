require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event, user: user)}
  let(:comment) { FactoryGirl.create(:comment, event: event) }
  let(:updated_comment) do
    FactoryGirl.attributes_for(:comment, author: 'Kravchuk', content: 'Another content')
  end

  context 'not authenticated user' do
    it 'shows' do
      get :show, event_id: event.id, id: comment.id

      expect(response.status).to eq 401
    end

    it 'creates' do
      expect{ post :create, comment: updated_comment, event_id: event.id }.not_to change(Comment, :count)

      expect(response.status).to eq 401
    end

    it 'destroys' do
      comment
      expect{ delete :destroy, id: comment.id, event_id: event.id }.not_to change(Comment, :count)

      expect(response.status).to eq 401
    end

    it 'updates' do
      expect{
        put :update, id: comment.id, comment: updated_comment, event_id: event.id
        comment.reload
      }.to change{ comment.updated_at }

      expect(response.status).to eq 401
    end
  end

  context 'authenticated user' do
    before(:each) do
      User.destroy_all # have to coz something wrong with token generation in spec:/
      request.headers.merge! user.create_new_auth_token
    end

    it 'shows' do
      get :show, id: comment.id, event_id: event.id

      expect(response.status).to eq 200
    end

    it 'creates' do
      expect{ post :create, comment: updated_comment, event_id: event.id }.to change(Comment, :count).by(1)

      expect(response.status).to eq 201
    end

    it 'destroys' do
      comment
      expect{ delete :destroy, id: comment.id, event_id: event.id }.to change(Comment, :count).by(-1)

      expect(response.status).to eq 204
    end

    it 'updates' do
      expect{
        put :update, id: comment.id, comment: updated_comment, event_id: event.id
        comment.reload
      }.to change{ comment.updated_at }

      expect(response.status).to eq 200
      expect(comment.author).to eq(updated_comment[:author])
      expect(comment.content).to eq(updated_comment[:content])
    end
  end
end
