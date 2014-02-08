class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user
      can :read, :all
      can :dashboard, User
    else
      can :new, :registrations
    end
  end
end