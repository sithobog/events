class Api::V1::EventInvitesController < Api::V1::BaseController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])
    invite = EventInvite.new(create_params)
    event.invites << invite

    if invite.valid?
      event.save!
      render(json: Api::V1::EventInviteSerializer.new(invite).to_json, status: 201)
    else
      render(json: { errors: invite.errors }, status: 422)
    end
  end

  private

  def create_params
    params.require(:event_invite).permit(:user_id)
  end
end
