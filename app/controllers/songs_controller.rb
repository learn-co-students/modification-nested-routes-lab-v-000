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
    if valid_artist?
      @song = Artist.find(params[:artist_id]).songs.build
    else
      redirect_to artists_path
    end
  end

  def create
    @song = Song.new(song_params)
    if valid_artist?(@song)
      redirect_to @song if @song.save
    else
      redirect_to artists_path
    end
  end

  def edit
    if nested_route?

      if valid_artist?
        @song = @artist.songs.find_by(id: params[:id])
        redirect_to artist_songs_path(@artist) if !@song
      else
        redirect_to(artists_path)
      end
    else # Not a nested route
      @song = Song.find_by(id: params[:id])
    end

  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)
    if !@song || !valid_artist?(@song)
      redirect_to artists_path
    end
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
    params.require(:song).permit(:title, :artist_id)
  end

  def valid_artist?(song = nil)
    if song
      !!song.artist
    else
      @artist = Artist.find_by(id: params[:artist_id])
    end
  end

  def nested_route?
    !!params[:artist_id]
  end
end

