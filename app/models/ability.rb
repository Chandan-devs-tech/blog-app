class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :read, :all
    can :manage, Post, author_id: user.id
    can :create, Comment
    can :create, Like
    can :destroy, Comment, user_id: user.id

    return unless user.admin?

    can :manage, :all
  end
end
