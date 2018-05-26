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
    # binding.pry
     # if there's an artist id, check to make sure it exists.
     # Send them to artist#index if it doesn't exist
    if params[:artist_id] && !Artist.exists?(params[:artist_id])
      redirect_to artists_path, alert: "Artist not found."
    else
      # if the artist_id existx, create the posts
      # create the posts even if the artist_id is nil
      @song = Song.new(:artist_id => params[:artist_id])
    end
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    # test to pass: validates artist when nested
    # test to pass: validates song for artist when nested
    #if there is an artist_id we know we're editing through the artist
    if params[:artist_id]
      artist = Artist.find_by_id(params[:artist_id])
      # if there is no artist, redirect to user to artists#index
      if artist.nil?
        redirect_to artists_path, alert: "Artist not found."
      else
        # if there is an artist see if the song exists in their collection
        @song = artist.songs.find_by_id(params[:id])
        # if the song doesn't exist then send them to the artist_song#index
        if @song.nil?
          redirect_to artist_songs_path(artist), alert: "Song not found."
          end
        end
      end
    # else the song will be pulled from the Song db
    else
    @song = Song.find_by_id(params[:id])
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
    params.require(:song).permit(:title, :artist_name, :artist_id)
  end
end
