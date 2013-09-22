class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.nil?
    #can :manage, Service, user_id: user.id
    can :manage, Resource, user_id: user.id
    #can :manage, ResourceColumn, resource: { user_id: user.id }
    #can :manage, ResourceColumnValue, resource_column: { resource: { service: { user_id: user.id } } }
  end
end
