# frozen_string_literal: true

class Api::V1::AccountsController < ApplicationController
  def index
    @accounts = accounts_service({}).index
    return render :index, status: :ok unless @accounts.empty?

    error(:no_content)
  end

  def show
    @account = accounts_service({ account_id: params[:id] }).show
    render :show, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    error(
      :not_found,
      e&.message
    )
  end

  def create
    @account = accounts_service(filtered_params).create
    render :create, status: :created
  rescue StandardError => e
    error(
      :unprocessable_entity,
      e&.message
    )
  end

  def update
    @account = accounts_service(filtered_params).update
    render :show, status: :ok
  rescue StandardError => e
    error(
      :unprocessable_entity,
      e&.message
    )
  end

  def destroy
    accounts_service({ account_id: params[:id] }).destroy
    head(:no_content)
  rescue ActiveRecord::RecordNotFound => e
    error(
      :not_found,
      e&.message
    )
  end

  private

  def accounts_service(filtered_params)
    @accounts_service ||= Api::V1::AccountsService.new(filtered_params)
  end

  def filtered_params
    params.require(:account).permit(
      :name,
      :client_name,
      :owner
    ).merge(id: params[:id])
  end
end
