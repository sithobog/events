class Api::V1::EventsController < Api::V1::BaseController
  before_action :authenticate_user!

  def show
    event = Event.find(params[:id])
    authorize event

    render(json: Api::V1::EventSerializer.new(event).to_json)
  end

  def index
    events = Event.filter(params, current_user)

    render(
      json: ActiveModel::Serializer::CollectionSerializer.new(
        events,
        serializer: Api::V1::EventSerializer,
        include: [:comments],
        root: 'events'
      )
    )
  end

  def create
    @event = Event.new(create_params)
    create_picture
    user = current_user
    user.events << @event

    if @event.valid?
      user.save!
      render(json: Api::V1::EventSerializer.new(@event).to_json, status: 201)
    else
      render(json: { errors: @event.errors }, status: 422)
    end
  end

  def update
    @event = Event.find(params[:id])
    authorize @event

    update_picture

    if @event.update_attributes(update_params)
      render(json: Api::V1::EventSerializer.new(@event).to_json, status: 200)
    else
      render(json: { errors: @event.errors }, status: 422)
    end

  end

  def destroy
    event = Event.find(params[:id])
    authorize event
    event.destroy

    head status: 204
  end

  private

  def create_picture
    if params[:picture]
      picture_params = params[:picture]
      @event.add_picture(picture_params[:file_data], picture_params[:file_name])
    end
  end

  def update_picture
    create_picture
  end

  def create_params
    params.require(:event).permit(:date, :place, :purpose, :description, :picture)
  end

  def update_params
    create_params
  end
end
