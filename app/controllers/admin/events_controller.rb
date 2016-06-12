class Admin::EventsController < ApplicationController

  before_action :authenticate_user!

  before_action :check_admin
  layout "admin"

  def index
    @events = Event.all
  end

  protected

  def check_admin #authenticate
       #authenticate_or_request_with_http_basic do |user_name, password|
           #user_name == "username" && password == "password"
       #end
      unless current_user.admin?
        raise ActiveRecord::RecordNotFound

      end
  end


end
