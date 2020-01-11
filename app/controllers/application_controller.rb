class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def find_artist(artist_id)
      @artist = Artist.find_by_id(artist_id)
    end
end
