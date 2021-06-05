class UsersController < ApplicationController
   # before_action :authorized, only: [auto_login]

    def create
        @user =  User.create(email: params[:email],password: params[:password])
        if @user.valid?
            @user.save
            UserMailer.with(user: @user).welcome_email.deliver_later
            payload = {user_id: @user.id}
            token = JWT.encode(payload, 'okcool', 'HS256')
            render json: {user:@user.email, token: token}, status: :created
        else
            render json: {error: "El usuario no pudo ser registrado"}
        end
    end

    # login a http://localhost:3000/users/login
        #{email: "maxisantomil@hotmail.com", password: "maipu1190"}
    def login 
        @user = User.find_by_email(params[:email])
        if @user && @user.authenticate(params[:password])
            payload = {user_id: @user.id}
            token = JWT.encode(payload, 'okcool', 'HS256')
            render json: {user:@user.email,token: token}, status: :ok
        else
            render json: {error: "Usuario o password no valido"}
        end
    end

    def auto_login
        render json:@user, message: "Bienvenido nuevamente"
    end

    def destroy
      user = User.find(params[:id])
      user.destroy
    end

    #def profile
    #    decoded_token = JWT.decode(request.headers[:token], 'okcool', true,{algorithm: 'HS256'})
    #    foundProfile = User.find(decoded_token[0]["user"])
    #    if foundProfile
    #        render json: foundProfile
    #    else
    #        render json: {error: "nose se encontro el perfil del usuario"}
    #    end
    #end
    
    private 
    def user_params
        params.require(:user).permit(:email, :password)
    end

end
