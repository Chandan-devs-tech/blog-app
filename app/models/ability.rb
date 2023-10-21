class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= current_user
    if user.role == 'admin'
      can :manage, :all
    else
      can :read, :all
      can :manage, Post, author_id: user.id
      can :manage, Comment, user_id: user.id
    end
  end
end
