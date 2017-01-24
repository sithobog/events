class Api::V1::CommentsController < Api::V1::BaseController
  before_action :authenticate_user!

  def show
    comment = Comment.find(params[:id])

    render(json: Api::V1::CommentSerializer.new(comment).to_json)
  end

  def index
    comments = Event.find(params[:event_id]).comments

    render(
      json: ActiveModel::Serializer::CollectionSerializer.new(
        comments,
        serializer: Api::V1::EventSerializer,
        root: 'comments'
      )
    )
  end

  def create
    event = Event.find(params[:event_id])
    comment = Comment.new(create_params)
    #return api_error(status: 422, errors: event.errors) unless comment.valid?
    event.comments << comment
    event.save!

    render(
      json: Api::V1::CommentSerializer.new(comment).to_json,
      status: 201,
    )
  end

  def update
    comment = Comment.find(params[:id])

    if !comment.update_attributes(update_params)
      #return api_error(status: 422, errors: comment.errors)
    end

    render(json: Api::V1::CommentSerializer.new(comment).to_json, status: 200)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy

    head status: 204
  end

  private

  def create_params
    params.require(:comment).permit(:author, :content)
  end

  def update_params
    create_params
  end
end
