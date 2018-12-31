class RegistrationsController < Devise::RegistrationsController

  protected

  # courtesy of https://www.mnishiguchi.com/2017/11/24/rails-devise-edit-account-without-password/
  def update_resource(resource, params)
    return super if params['password'].present?
    resource.update_without_password(params.except('current_password'))
  end
end
