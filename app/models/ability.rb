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
        can [:create, :index_custom_contractor], Booking
        can [:update, :destroy, :cancel], Booking do |booking|
            booking.try(:profile_contractor) == user.profileable
        end
        can [:create, :index_custom, :index_custom_invite], Casting
        can [:edit_photos, :index_invite, :index_invited, :index_applied, :index_confirmed, :manage, :invite, :update, :activate, :close, :cancel], Casting do |casting|
            casting.try(:ownerable) == user.profileable
        end
        can [:read, :read_all, :unread_all], Message
        can [:show, :destroy], Message do |message|
            message.try(:ownerable) == user.profileable
        end
        can [:show, :create, :uploaded], Photo
        can :destroy, Photo do |photo|
            photo.attachable.try(:ownerable) == user.profileable
        end
        can :create, ProfileContractor
        can :update, ProfileContractor do |profile|
            profile.try(:user) == user
        end
        can :create, Review
        can :show, Study
    elsif user.model?
        can :read, Album
        can :index_custom_model, Booking
        can [:confirm, :reject] , Booking do |booking|
            booking.try(:profile_model) == user.profileable
        end
        can [:confirm, :apply], Casting
        can [:read, :read_all, :unread_all], Message
        can [:show, :destroy], Message do |message|
            message.try(:ownerable) == user.profileable
        end
        can :create, ProfileModel
        can :update, ProfileModel do |profile|
            profile.try(:user) == user
        end
        can [:show, :create, :uploaded], Photo
        can :destroy, Photo do |photo|
            photo.attachable.try(:profileable) == user.profileable
        end
        can [:read, :show, :create], Study
        can [:update, :destroy], Study do |study|
            study.try(:ownerable) == user.profileable
        end
    elsif user.photographer?
        can :read, Album
        can [:read, :read_all, :unread_all], Message
        can [:show, :destroy], Message do |message|
            message.try(:ownerable) == user.profileable
        end
        can :create, ProfilePhotographer
        can :update, ProfilePhotographer do |profile|
            profile.try(:user) == user
        end
        can :show, Study
    end
  end
end
