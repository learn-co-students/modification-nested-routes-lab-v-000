require 'pry'
class SongsController < ApplicationController
  def index
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
        @songs = @artist.songs
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @song = @artist.songs.find_by(id: params[:id])
      if @song.nil?
        redirect_to artist_songs_path(@artist), alert: "Song not found"
      end
    else
      @song = Song.find(params[:id])
    end
  end

  def new
    @song = Song.new
    if params[:artist_id] && !Artist.exists?(params[:artist_id]) 
      
      redirect_to artists_path, alert: "Artist not found."
    else
      @song = Song.new(artist_id: params[:artist_id])
    end

    #This is an if/else modeled after the readme section
    #Here we check for params[:artist_id] and then for Artist.exists? to see if the artist is real.
  end

  def create
    #binding.pry
    @song = Song.new(song_params)
    @song.artist_id = params[:song][:artist_id]  #this was added for POST create accepts and sets artist_id
    @song.save
    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found."
      else
        @song = @artist.songs.find_by(id: params[:id])
        redirect_to artist_songs_path(@artist), alert: "Song not found." if @song.nil?
      end
    else
      if Song.find(params[:id])
        @song = Song.find(params[:id])
      else
        redirect_to artist_songs_path(@artist), alert: "Song not found."
      end
    end
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

