# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if user_signed_in?
      render :index
    else
      render 'welcome/index'
    end
  end
end
