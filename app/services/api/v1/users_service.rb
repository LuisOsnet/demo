# frozen_string_literal: true

module Api
  module V1
    class UsersService
      def initialize(params = {})
        @params = params
      end

      ##
      # It returns all the users in the database.
      def index
        User.all_except(@params[:current_user])
      end

      ##
      # It finds a user by their id
      def show
        User.find(@params[:user_id])
      end

      ##
      # It creates a user and adds roles to it if the user is created
      def create
        ActiveRecord::Base.transaction do
          user = User.create!(@params.except(:role))
          add_roles_to(user) if user
          user
        end
      end

      ##
      # It updates a user, destroys all of their roles, and then adds new roles to
      # the user
      def update
        ActiveRecord::Base.transaction do
          user = User.update!(@params[:id], @params.except(:role))
          user.roles.destroy_all if user.roles.any? && @params[:role].present?
          add_roles_to(user)
          user
        end
      end

      ##
      # It destroys a user
      def destroy
        User&.destroy @params[:user_id]
      end

      private

      ##
      # > Add roles to a user
      #
      # Args:
      #   user: The user object that we're adding roles to.
      #
      # Returns:
      #   The return value of the last line of the method.
      def add_roles_to(user)
        return if user.nil?

        user.add_role @params[:role]&.to_sym
      end
    end
  end
end
