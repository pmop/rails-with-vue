class SignupController < ApplicationController
  def create
    user = User.new user_params

    if user.save
      # Assign user id to payload
      payload = { user_id: user.id }
      # Pass the payload to, and create the session
      session = JWTSessions::Session.new(payload: payload,
                                         refresh_by_access_allowed: true)
      tokens = session.login
      # Set cookie with response (determine if user is logged in or not)
      response.set_cookie(JWTSessions.access_cookie,
                          values: tokens[:access],
                          httponly: true,
                          secure: Rails.env.production?)
      # Render the final response as csrf (safe response)
      render json: { csrf: tokens[:csrf] }
    else
      # If not, return an error
      render json: { error: user.errors.full_messages.join(' ') },
        status: unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
