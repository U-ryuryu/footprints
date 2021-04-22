class ClientsController < ApplicationController
  def index
    if admin_signed_in?
      @clients = Client.where(admin_id: current_admin.id)
    elsif user_signed_in?
      @clients = Client.where(admin_id: current_user.admin.id)
    end
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(params_client)
    if @client.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def params_client
    if admin_signed_in?
      params.require(:client).permit(:name, :tel, :postal_code, :address, :charge, :charge_tel).merge(admin_id: current_admin.id)
    else
      params.require(:client).permit(:name, :tel, :postal_code, :address, :charge, :charge_tel).merge(admin_id: current_user.admin.id)
    end
  end
end
