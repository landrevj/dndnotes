class Ability
  include CanCan::Ability

  def initialize(user)
    # alias_action :update, :destroy, to: :modify
    if user.present?
      can :manage, Category, user_id: user.id
      can :manage, Link, user_id: user.id
      can :manage, Note, user_id: user.id
    end
    
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
