class Users::SessionsController < Devise::SessionsController
    before_action :authenticate_user!, except: %i[create]

    def destroy
        if user_signed_in?
            sign_out(current_user)
            render json: {
                message: 'You are logged out.'
              }, status: :ok
        else
            render json: {message: 'invalid token'}, status: :unauthorized
        end
    end

    private

    def respond_to_on_destroy
        log_out_success && return unless current_user

        log_out_failure

    end

    def log_out_success
        render json: {message: 'You are logged out'}, status: :ok
    end

    def log_out_failure
        render json: {message:"something wrong"}, status: :unauthorized
    end

    def respond_with(_rescue, _opts = {})
        if current_user.nil?
            render json: {message: 'Invalid email or password'}, status: :unauthorized
        else
        render json: {
            message: "success",
            user:current_user
        } status: :ok
        end
    end
end