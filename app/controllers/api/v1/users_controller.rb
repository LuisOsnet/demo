class Api::V1::UsersController < ApplicationController
  def index
    authorize :user, :index?
    @users = users_service({ current_user: current_user }).index
    return render :index, status: :ok unless @users.empty?

    error(:no_content)
  rescue StandardError => e
    notify(e)
    error(
      :unprocessable_entity,
      e&.message
    )
  end

  def show
    return show_user if current_user.has_role? :user

    authorize :user, :show?
    @user = users_service({ user_id: params[:id] }).show
    render :show, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    notify(e)
    error(
      :not_found,
      e&.message
    )
  end

  def show_user
    authorize :user, :show_user?
    @user = users_service({ user_id: current_user.id }).show
    render :show_user, status: :ok
  end

  def create
    authorize :user, :create?
    @user = users_service(filtered_params).create
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
    @user = users_service(filtered_params).update
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
    users_service({ user_id: params[:id] }).destroy
    head(:no_content)
  rescue StandardError => e
    notify(e)
    error(
      :unprocessable_entity,
      e&.message
    )
  end

  private

  def users_service(filtered_params)
    @users_service ||= Api::V1::UsersService.new(filtered_params)
  end

  ##
  # `filtered_params` is a function that takes in the params hash and returns a
  # hash with only the keys that we want
  def filtered_params
    params.require(:user).permit(
      :name,
      :level_english,
      :technical_knowledge,
      :resume_url,
      :email,
      :password,
      :role
    ).merge(id: params[:id])
  end
end
