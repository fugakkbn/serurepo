# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    if user_signed_in?
      render :index
    else
      render template: 'welcome/index'
    end
  end
end
