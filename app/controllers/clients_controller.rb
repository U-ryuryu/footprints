class ClientsController < ApplicationController
  before_action :redirect_admin, except: :index
  before_action :redirect_user, only: [:show,:edit,:update,:destroy]
  def index
      if user_signed_in?
        @client = Client.where(admin_id: current_user.admin.id).order(updated_at: "DESC").includes(:admin)
      end
  end

  def search
    @client = Client.search(params[:keyword]).where(admin_id: current_user.admin.id).order(updated_at: "DESC").includes(:admin)
  end

  def show
    @visits = Visit.where(client_id: @client.id).order(updated_at: "DESC").includes(:user,:client)
    @calls = Call.where(client_id: @client.id).order(updated_at: "DESC").includes(:user,:client)
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @client.update(client_params)
      redirect_to client_path(@client.id)
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path and return if user_signed_in?
    @client.delete
    redirect_to root_path
  end

  private

  def client_params
    params.require(:client).permit(:name, :tel, :postal_code, :address, :charge, :charge_tel).merge(admin_id: current_user.admin.id)
  end

  def redirect_admin
    redirect_to root_path unless user_signed_in?
  end

  def redirect_user
    @client = Client.find(params[:id])
    if user_signed_in?
      redirect_to root_path if current_user.admin.id != @client.admin.id
    end
  end
end
