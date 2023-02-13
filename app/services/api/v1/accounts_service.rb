# frozen_string_literal: true

module Api
  module V1
    class AccountsService
      def initialize(params = {})
        @params = params
      end

      def index
        Account.all
      end

      def show
        Account.find(@params[:account_id])
      end

      def create
        Account.create!(@params)
      end

      def update
        Account.update!(@params[:id], @params)
      end

      def destroy
        Account&.destroy @params[:account_id]
      end
    end
  end
end