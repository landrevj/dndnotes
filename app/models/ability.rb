class Ability
  include CanCan::Ability

  def initialize(user)
    # alias_action :update, :destroy, to: :modify
    if user.present?
      can :manage, Workspace, user_id: user.id
      can :manage, Category, user_id: user.id
      can :manage, Note, user_id: user.id
      can :manage, Link, user_id: user.id
      if user.admin?
        can :access, :rails_admin
        can :read, :dashboard
        can :manage, :all
      end
    end

    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
