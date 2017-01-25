class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def show?
    owner? || invited?
  end

  def create?
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
    @comment.event.user_id == @user.id
  end

  def invited?
    EventInvite.find_by(user_id: @user.id, event_id: @comment.event.id)
  end
end
