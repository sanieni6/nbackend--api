class Admins::SessionsController < Devise::SessionsController
    before_action :authenticate_admin!, except: %i[create]
  
    def destroy
      if admin_signed_in?
        sign_out(current_admin)
        render json: {
          message: 'You are logged out.'
        }, status: :ok
      else
        render json: { message: 'Invalid token.' }, status: :unauthorized
      end
    end
  
    private
  
    def respond_to_on_destroy
      log_out_success && return unless current_admin
  
      log_out_failure
    end
  
    def log_out_success
      render json: { message: 'You are logged out.' }, status: :ok
    end
  
    def log_out_failure
      render json: { message: 'Hmm nothing happened.' }, status: :unauthorized
    end
  
    def respond_with(_resource, _opts = {})
      if current_admin.nil?
        render json: { message: 'Invalid email or password.' }, status: :unauthorized
      else
        render json: {
          message: 'You are logged in.',
          admin: current_admin
        }, status: :ok
      end
    end
  end