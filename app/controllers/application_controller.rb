class ApplicationController < ActionController::API
     before_action :authorized

     def authorized
        render json: { message: 'Please log in' }, status: :unauthorized unless
        logged_in
     end

     # returns true or false based on logged_in_user returns true or false
     def logged_in
        !!logged_in_user
    end

    def logged_in_user
        # check if the variable exists and is truthy and is an authentication token containing user information
        # then we extract the user_id from the decoded_token and search it on the db
        if decoded_token
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end

    def decoded_token
        if auth_header
            token = auth_header.split(' ')[1]
            #header: { 'Authorization': 'Bearer <token>' }
            begin
                JWT.decode(token, 'yourSecret', true, algorithm: 'HS256')
            rescue JWT::DecodeError
                nil
            end
        end
    end

     def auth_header
        # { Authorization: 'Bearer <token>' }
        request.headers['Authorization']
     end

     def encode_token(payload)
        JWT.encode(payload, 'yourSecret')
     end

end
