class PagesController < ApplicationController

  skip_before_action :require_authentication

  def index
  end

  def stats
  end

  def landing
  end

  def terms
    render :terms
  end

  def landing_coffee
  end
end
