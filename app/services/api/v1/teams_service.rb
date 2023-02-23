# frozen_string_literal: true

module Api
  module V1
    class TeamsService
      def initialize(params = {})
        @params = params
      end

      def index
        Team.all
      end

      def show
        Team.find(@params[:team_id])
      end

      def create
        ActiveRecord::Base.transaction do
          Team.create!(@params)
        end
      end

      def update
        Team.update!(@params[:id], @params)
      end

      def destroy
        Team&.destroy @params[:team_id]
      end

      def assign
        ActiveRecord::Base.transaction do
          team = Team.find(@params[:id])
          user = User.find(@params[:user_id])
          team.users << user
          add_log(user, team)
          team
        end
      end

      def remove
        ActiveRecord::Base.transaction do
          team = Team.find(@params[:id])
          user = User.find(@params[:user_id])
          team.users.delete(user)
          update_log(user, team)
          team
        end
      end

      private

      def add_log(user, team)
        track = team.tracks.build(
          user_id: user.id,
          user_name: user.name,
          team_id: team.id,
          team_name: team.name,
          started_at: Time.now
        )

        track.save
      end

      def update_log(user, team)
        track = team.tracks.where(
          user_id: user.id,
          team_id: team.id,
          ended_at: nil
        ).last
        track&.update!(ended_at: Time.now)
      end
    end
  end
end
