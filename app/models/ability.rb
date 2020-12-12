# frozen_string_literal: true

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

    do_alias

    admin_ability(user) if user&.admin?
    user_ability(user) if user&.user? || user&.admin?
    general_ability(user)
  end

  def do_alias
    alias_action :index, :show, to: :read
    alias_action :index, :show, :create, :new, :read, :update, :destroy, :to => :crud
    alias_action :update, :destroy, :disable, :enable, :to => :modify
    alias_action :block, :unblock, :to => :modify_blockship
  end

  def admin_ability(user)
    can :manage, :all
  end

  def user_ability(user)
    can :crud, Post, user_id: user.id
    can [:crud, :modify], User, id: user.id
    can :modify_blockship, User
    can :create, Comment
    can :destroy, Comment, user_id: user.id
  end

  def general_ability(user)
    can :read, Post, published: true
    can :read, User, disabled: false

    cannot :disable, User, disabled: true
    cannot :enable, User, disabled: false
    cannot :disable, User, id: user.id unless user.nil?
    cannot :enable, User, id: user.id unless user.nil?
    cannot :modify_blockship, User, id: user.id unless user.nil?
  end
end
