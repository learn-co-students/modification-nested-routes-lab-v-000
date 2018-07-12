class SongsController < ApplicationController
  before_action :set_song, only: [:update, :destroy]
  
  def index
    if artist_id
      set_artist
      @artist.nil? ? (redirect_to artists_path, alert: "Artist not found") : (@songs = @artist.songs)
    else
      @songs = Song.all
    end
  end

  def show
    if artist_id
      set_artist && set_artist_song
      redirect_to artist_songs_path(@artist), alert: "Song not found" if @song.nil?
    else
      set_song
    end
  end

  def new
    artist_id && !Artist.exists?(artist_id) ? (redirect_to artists_path) : (@song = Song.new(artist_id: artist_id))
  end

  def create
    @song = Song.new(song_params)
    @song.save ? (redirect_to @song) : (render :new)
  end

  def edit
    if artist_id
      set_artist
      
      if @artist.nil?
        redirect_to artists_path
      else
        set_artist_song
        redirect_to artist_songs_path(@artist) if @song.nil?
      end
      
    else
      set_song
    end
  end

  def update
    @song.update(song_params)
    @song.save ? (redirect_to @song) : (render :edit)
  end

  def destroy
    @song.destroy
    redirect_to songs_path, alert: 'Song deleted.'
  end

private

  def set_song
    @song = Song.find_by(id: params[:id])
  end
  
  def set_artist
    @artist = Artist.find_by(id: artist_id)
  end
  
  def set_artist_song
    @song = @artist.songs.find_by(id: params[:id])
  end
  
  def artist_id
    params[:artist_id]
  end

  def song_params
    params.require(:song).permit(:title, :artist_name, :artist_id)
  end
end