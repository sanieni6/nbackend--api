class ApplicationController < ActionController::API
    before_action :authenticate_user!

    private

    def authenticate_user!
        if request.headers['Authorization'].present?
            token = request.headers['Authorization'].split[1]
            begin
                decoded_token = JWT.decode(token, Rails.Application.credentials.devise[:jwt_secret_key],
                veryify_expiration: true)
                @current_user =  User.find(decoded_token[0]['sub'])
            rescue ActiveRecord::RecordNotFound
                render json: {message: 'User not found'}, status: :not_found
            end
        else 
           render json: {message: 'Unauthorizwed'} , status: :Unauthorized
        end
    end
end
