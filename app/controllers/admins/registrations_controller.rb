class Admins::RegistrationsController < Devise::RegistrationsController
    before_action :authenticate_admin!, except: %i[create]
  
    def create
      build_resource(sign_up_params)
  
      if resource.save
        sign_in(resource)
        register_success
      else
        register_failed(resource)
      end
    end
  
    private
  
    def sign_up_params
      params.require(:admin).permit(:email, :password, :password_confirmation)
    end
  
    def respond_with(resource, _opts = {})
      register_success && return if resource.persisted?
  
      register_failed
    end
  
    def register_success
      render json: {
        message: 'Signed up sucessfully.',
        user: current_admin
      }, status: :ok
    end
  
    def register_failed
      render json: { message: 'Something went wrong.', errors: resource.errors.full_messages },
             status: :unprocessable_entity
    end
  end