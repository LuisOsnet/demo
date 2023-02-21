# frozen_string_literal: true

class Api::V1::TeamsController < ApplicationController
	def index
    authorize :user, :index?
    @teams = teams_service({}).index
    return render :index, status: :ok unless @teams.empty?

    error(:no_content)
  rescue StandardError => e
    notify(e)
    error(
      :unprocessable_entity,
      e&.message
    )
  end

	def show
    authorize :user, :show?
    @team = teams_service({ team_id: params[:id] }).show
    render :show, status: :ok
  rescue StandardError => e
    notify(e)
    error(
      :unprocessable_entity,
      e&.message
    )
  end

	def create
    authorize :user, :create?
		@team = teams_service(filtered_params).create
		render :create, status: :created
	rescue StandardError => e
    notify(e)
		error(
			:unprocessable_entity,
			e&.message
		)
	end

	def update
    authorize :user, :update?
    @team = teams_service(filtered_params).update
    render :show, status: :ok
  rescue StandardError => e
    notify(e)
    error(
      :unprocessable_entity,
      e&.message
    )
  end

	def destroy
    authorize :user, :destroy?
    teams_service({ team_id: params[:id] }).destroy
    head(:no_content)
  rescue StandardError => e
    notify(e)
    error(
      :unprocessable_entity,
      e&.message
    )
  end

  def assign_user
    authorize :user, :assign_user?
		@team = teams_service(filtered_params).assign
		render :show, status: :created
	rescue StandardError => e
    notify(e)
		error(
			:unprocessable_entity,
			e&.message
		)
	end

  def remove_user
    authorize :user, :remove_user?
		@team = teams_service(filtered_params).remove
		render :show, status: :created
	rescue StandardError => e
    notify(e)
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