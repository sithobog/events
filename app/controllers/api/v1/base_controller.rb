class Api::V1::BaseController < ApplicationController
  include ActiveHashRelation
  include Pundit

  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :destroy_session

  def destroy_session
    request.session_options[:skip] = true
  end

  def not_found
    render json: { error: 'Not found' }, status: :not_found
  end

  def user_not_authorized
    render json: { error: 'Not allowed' }, status: :forbidden
  end
end
