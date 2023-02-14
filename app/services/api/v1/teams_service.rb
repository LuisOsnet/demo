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
		end
	end
end