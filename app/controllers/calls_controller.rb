class CallsController < ApplicationController
  def new
    @call = Call.new
  end

  def create
    @call = Call.new(call_params)
    if @call.save
      redirect_to client_path(params[:client_id])
    else
      render :new
    end
  end

  private

  def call_params
    params.require(:call).permit(:title, :date, :content, :status_id).merge(user_id: current_user.id, client_id: params[:client_id])
  end
end
