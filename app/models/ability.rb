class Ability
  include CanCan::Ability
  
  def initialize(persona)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    persona ||= Persona.new
    
    if persona.has_role? :admin
      can :manage, :all
      can :read, :all
    elsif persona.has_role? :editor
      can [:destroy, :update], Idea
      can [:create, :update], Comentario, :persona_id => persona.id
      can :destroy, Comentario
      can :read, :all
    elsif persona.has_role? :usuario
      can :create, Idea
      can [:update, :destroy], Idea, :persona_id => persona.id
      can [:create, :update], Comentario, :persona_id => persona.id
    else
      can :read, :all
      can :create, Comentario
    end
  end
end
