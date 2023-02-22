class Api::V1::TracksController < ApplicationController
  def index
    authorize :user, :index?
    @records = Track.ransack(sanitize_params).result
    return render :index, status: :ok unless @records.empty?

    error(:no_content)
  rescue StandardError => e
    notify(e)
    error(
      :unprocessable_entity,
      e&.message
    )
  end

  private

  def filtering_params
    params.slice(:user_id, :user_name, :team_id, :team_name, :started_at, :ended_at)
  end

  def sanitize_params
    {
      user_id_eq: filtering_params[:user_id],
      user_name_eq: filtering_params[:user_name],
      team_id_eq: filtering_params[:team_id],
      team_name_eq: filtering_params[:team_name],
      started_at_eq: filtering_params[:started_at],
      ended_at_eq: filtering_params[:ended_at]
    }
  end
end
