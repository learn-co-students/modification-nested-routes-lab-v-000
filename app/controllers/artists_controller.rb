class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :edit, :update, :destroy]
  
  def index
    @artists = Artist.all
  end

  def show
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    @artist.save ? (redirect_to @artist) : (render :new)
  end

  def edit
  end

  def update
    @artist.update(artist_params)
    @artist.save ? (redirect_to @artist) : (render :edit)
  end

  def destroy
    @artist.destroy
    redirect_to artists_path, alert: 'Artist deleted.'
  end

private

  def set_artist
    @artist = Artist.find(params[:id])
  end

  def artist_params
    params.require(:artist).permit(:name)
  end
end