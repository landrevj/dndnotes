class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :update, :destroy, to: :modify
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
