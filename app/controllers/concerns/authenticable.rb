module Authenticable
  def current_user
    return @current_user if @current_user

    token = request.headers["Authorization"]&.split&.last

    if token
      decoded = JsonWebToken.decode(token)
      @current_user ||= User.find(decoded[:user_id])
      return @current_user if @current_user&.auth_token == token
    end

    nil
  end
end
