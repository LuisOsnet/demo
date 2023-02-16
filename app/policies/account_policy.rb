# frozen_string_literal: true

class AccountPolicy < ApplicationPolicy
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

  def create?
    @user.has_role?(:admin) || @user.has_role?(:super_user)
  end

  def update?
    @user.has_role?(:admin) || @user.has_role?(:super_user)
  end

  def destroy?
    @user.has_role?(:admin) || @user.has_role?(:super_user)
  end
end