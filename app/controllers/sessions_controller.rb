# dunnny model for form validation - no corresponding db table
class Session
  include ActiveModel::Model

  attr_accessor :email, :password

  validates :email, presence: true
  validates :password, presence: true
end

class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)
    @session.valid?

    user = User.authenticate_with_credentials(params[:session][:email], params[:session][:password])

    if user
      session[:user_id] = user.id
      redirect_to :root
    else
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
  
    private
  
    def session_params
      params.require(:session).permit(
        :email,
        :password
      )
    end
end
