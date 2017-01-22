class Api::V1::BaseController < ApplicationController
  include ActiveHashRelation
  
  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  before_action :destroy_session

  def destroy_session
    request.session_options[:skip] = true
  end

  def not_found
    render json: { error: 'Not found' }, status: :not_found
  end
end