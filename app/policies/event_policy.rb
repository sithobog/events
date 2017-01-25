class EventPolicy < ApplicationPolicy
  attr_reader :user, :event

  def initialize(user, event)
    @user = user
    @event = event
  end

  def show?
    owner? || invited?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  protected

  def owner?
    @event.user_id == @user.id
  end

  def invited?
    EventInvite.find_by(user_id: @user.id, event_id: @event_id)
  end
end
