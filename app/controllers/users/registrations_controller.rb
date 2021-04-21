# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  prepend_before_action :authenticate_scope!, only: [:destroy]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
   def new
    if admin_signed_in?
     super
    else
      redirect_to root_path
    end
   end

  # POST /resource
   def create
    if admin_signed_in?
      super
     else
       redirect_to root_path
     end
   end

  # GET /resource/edit
  def edit
    if admin_signed_in?
      if current_admin.id == User.find(params[:id]).admin.id
        self.resource = resource_class.to_adapter.get!(params[:id])
      else
        redirect_to root_path
      end
    else
      authenticate_scope!
+      super
    end
  end

  # PUT /resource
  def update
    if admin_signed_in?
      if current_admin.id == User.find(params[:id]).admin.id
        self.resource = resource_class.to_adapter.get!(params[:id])
      else
        redirect_to root_path
      end
    else
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    end

    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    if admin_signed_in?
      if current_admin.id == User.find(params[:id]).admin.id
        resource_updated = update_resource_without_password(resource, account_update_params)
      end
    else
      resource_updated = update_resource(resource, account_update_params)
    end
    yield resource if block_given?

    if resource_updated
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up).merge(admin_id: current_admin.id)
  end
  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def sign_up(resource_name, resource)
  end

  def update_resource_without_password(resource, params)
    resource.update_without_password(params)
  end
  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
