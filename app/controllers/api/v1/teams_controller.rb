# frozen_string_literal: true

class Api::V1::TeamsController < ApplicationController
	def index
    @teams = teams_service({}).index
    return render :index, status: :ok unless @teams.empty?

    error(:no_content)
  end

	def show
    @team = teams_service({ team_id: params[:id] }).show
    render :show, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    error(
      :not_found,
      e&.message
    )
  end

	def create
		@team = teams_service(filtered_params).create
		render :create, status: :created
	rescue StandardError => e
		error(
			:unprocessable_entity,
			e&.message
		)
	end

	def update
    @team = teams_service(filtered_params).update
    render :show, status: :ok
  rescue StandardError => e
    error(
      :unprocessable_entity,
      e&.message
    )
  end

	def destroy
    teams_service({ team_id: params[:id] }).destroy
    head(:no_content)
  rescue ActiveRecord::RecordNotFound => e
    error(
      :not_found,
      e&.message
    )
  end

  def assign_user
		@team = teams_service(filtered_params).assign
		render :show, status: :created
	rescue StandardError => e
		error(
			:unprocessable_entity,
			e&.message
		)
	end

  def remove_user
		@team = teams_service(filtered_params).remove
		render :show, status: :created
	rescue StandardError => e
		error(
			:unprocessable_entity,
			e&.message
		)
	end

	private

  def teams_service(filtered_params)
    @teams_service ||= Api::V1::TeamsService.new(filtered_params)
  end

	def filtered_params
    params.require(:team).permit(
      :name,
			:account_id,
      :user_id
    ).merge(id: params[:id])
  end
end