class EventPolicy < ApplicationPolicy
  attr_reader :user, :event

  def initialize(user, event)
    @user = user
    @event = event
  end

  def show?
    owner?
    #and invitations
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
end
