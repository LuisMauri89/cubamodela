class Ability
  include CanCan::Ability

  def initialize(user)
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

    user ||= User.new # guest user (not logged in)
    if user.admin?
        can :manage, :all
    elsif user.contractor?
        can :create, ProfileContractor
        can :update, ProfileContractor do |profile|
            profile.try(:user) == user
        end
        can :create, Casting
        can [:edit_photos, :index_invite, :index_invited, :index_applied, :index_confirmed, :manage, :invite, :update, :activate, :close, :cancel, :destroy], Casting do |casting|
            casting.try(:ownerable) == user.profileable
        end
        can [:index_custom, :index_custom_invite], Casting
        can :create, Booking
        can [:update, :destroy], Booking do |booking|
            booking.try(:profile_contractor) == user.profileable
        end
    elsif user.model?
        can :create, ProfileModel
        can :update, ProfileModel do |profile|
            profile.try(:user) == user
        end
        can [:confirm, :apply], Casting
        can :confirm , Booking do |booking|
            booking.try(:profile_model) == user.profileable
        end
    elsif user.photographer?
        can :create, ProfileModel
        can :update, ProfileModel do |profile|
            profile.try(:user) == user
        end
    end
  end
end
