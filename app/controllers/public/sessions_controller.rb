# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :reject_inactive_customer, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end


 private

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  def reject_inactive_customer
    @customer = Customer.find_by(email: params[:customer][:email])

    if @customer && !@customer.is_active
      flash[:danger] = '退会済みニャ、別のメールアドレスを使うニャ(=ↀωↀ=)'
      redirect_to new_customer_session_path
    elsif !@customer
      flash[:danger] = '項目を入力してニャ(=ↀωↀ=)'
      redirect_to new_customer_session_path
    end
  end

  def after_sign_in_path_for(resource)
    public_customer_path(current_customer)
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end

