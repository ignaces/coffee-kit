class Barista::UsersController < Barista::BaristaController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.order(:first_name).page(params[:page])
  end

  def show
  end

  private

    def set_user
      @user = User.find(params[:id])
    end


end