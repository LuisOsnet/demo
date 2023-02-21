# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  attr_reader :user
  
  def initialize(user, _record)
    @user = user
  end

  def index?
    @user.has_role?(:admin) || @user.has_role?(:super_user)
  end

  def show?
    @user.has_role?(:admin) || @user.has_role?(:super_user)
  end

  def show_user?
    @user.has_role?(:user)
  end

  def create?
    @user.has_role?(:admin) || @user.has_role?(:super_user)
  end

  def update?
    @user.has_role?(:admin) || @user.has_role?(:super_user)
  end

  def destroy?
    @user.has_role?(:admin) || @user.has_role?(:super_user)
  end

  def assign_user?
    @user.has_role?(:admin) || @user.has_role?(:super_user)
  end

  def remove_user?
    @user.has_role?(:admin) || @user.has_role?(:super_user)
  end
end