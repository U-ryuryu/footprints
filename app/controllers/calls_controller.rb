class CallsController < ApplicationController
  before_action :redirect_user
  before_action :redirect_current_user, only: [:edit, :update, :destroy]
  def new
    @call = Call.new
  end

  def create
    @call = Call.new(call_params)
    if @call.save
      @call.client.touch
      redirect_to client_path(params[:client_id])
    else
      render :new
    end
  end

  def show
    @call = Call.find(params[:id])
    @call_comment = CallComment.new
    @call_comments = @call.call_comments.includes(:user)
  end

  def edit
  end

  def update
    if @call.update(call_params)
      @call.client.touch
      redirect_to client_call_path
    else
      render :edit
    end
  end

  def destroy
    @call.delete
    redirect_to client_path(params[:client_id])
  end

  private

  def call_params
    params.require(:call).permit(:title, :date, :content, :status_id).merge(user_id: current_user.id, client_id: params[:client_id])
  end

  def redirect_user
    if user_signed_in?
      redirect_to root_path and return unless current_user.admin.id == Client.find(params[:client_id]).admin.id
    else
      redirect_to root_path
    end
  end

  def redirect_current_user
    @call = Call.find(params[:id])
    redirect_to root_path if current_user.id != @call.user_id
  end
end
