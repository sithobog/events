class Api::V1::EventsController < Api::V1::BaseController
  before_action :authenticate_user!

  def show
    event = Event.find(params[:id])
    authorize event

    render(json: Api::V1::EventSerializer.new(event).to_json)
  end

  def index
    events = Event.all

    render(
      json: ActiveModel::Serializer::CollectionSerializer.new(
        events,
        serializer: Api::V1::EventSerializer,
        root: 'events'
      )
    )
  end

  def create
    event = Event.new(create_params)
    create_picture
    #return api_error(status: 422, errors: event.errors) unless event.valid?
    user = current_user
    user.events << event
    user.save!

    render(
      json: Api::V1::EventSerializer.new(event).to_json,
      status: 201,
    )
  end

  def update
    event = Event.find(params[:id])
    authorize event

    if !event.update_attributes(update_params)
      #return api_error(status: 422, errors: event.errors)
    end

    render(json: Api::V1::EventSerializer.new(event).to_json, status: 200)
  end

  def destroy
    event = Event.find(params[:id])
    authorize event
    event.destroy

    head status: 204
  end

  private

  def create_picture
  end

  def create_params
    params.require(:event).permit(:date, :place, :purpose, :description)
  end

  def update_params
    create_params
  end
end
