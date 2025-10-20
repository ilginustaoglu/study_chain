class LandingController < ApplicationController
  # Landing page - only for non-authenticated users
  def index
    if user_signed_in?
      redirect_to authenticated_root_path
    end
  end
end
