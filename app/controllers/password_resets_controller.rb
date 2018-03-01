class PasswordResetsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:password_reset][:email].try(:downcase))

    if user && user.send_password_reset_email
      redirect_to signin_path, notice: "Te enviamos un correo a #{user.email} con las instrucciones para recuperar tu contraseña."
    else
      flash.now[:notice] = "El Email ingresado no está registrado"
      render :new
    end
  end

  def edit
    redirect_to signin_path unless User.find_by(password_recovery_token: params[:id])
  end

  def update
    user = User.find_by(password_recovery_token: params[:id])
    if user && user.reset_password(params[:password_reset][:password])
      redirect_to signin_path, notice: 'Tu nueva contraseña fue generada'
    else
      flash.now[:error] = 'Ocurrió un error al generar tu nueva contraseña'
      render :edit
    end
  end

end
