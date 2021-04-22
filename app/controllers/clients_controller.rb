class ClientsController < ApplicationController
  def index
    if admin_signed_in?
      @client = Client.where(admin_id: current_admin.id)
    elsif user_signed_in?
      @client = Client.where(admin_id: current_user.admin.id)
    end
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
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    if @client.update(client_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def client_params
    if admin_signed_in?
      params.require(:client).permit(:name, :tel, :postal_code, :address, :charge, :charge_tel).merge(admin_id: current_admin.id)
    else
      params.require(:client).permit(:name, :tel, :postal_code, :address, :charge, :charge_tel).merge(admin_id: current_user.admin.id)
    end
  end
end
