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
    if Artist.find_by(id: params[:artist_id])
      @song = Song.new(artist_id: params[:artist_id])
    else
      redirect_to artists_path
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

  def edit #this method is wrong....
    #checks if we are nested and both song and artist exist
    if Artist.find_by(id: params[:artist_id]) && Song.find_by(id: params[:id])
      @song = Song.find_by(id: params[:id])
      @artist = Artist.find_by(id: params[:artist_id])
      @artist.songs << @song
    #checks if song exists
    elsif Song.find_by(id: params[:id]) == nil
      @artist = Artist.find_by(id: params[:artist_id])
      redirect_to artist_songs_path(@artist)
    #if we are nested and song exists but artist doesn't
    elsif Artist.find_by(id: params[:artist_id]) == nil
        redirect_to artists_path
      #if we're not nested
    elsif Song.find_by(id: params[:id])
      @song = Song.find_by(id: params[:id])
      redirect_to song_path(@song)
      #if none of the above just go back to artists path
    elsif !Song.find_by(id: params[:id]) && Artist.find_by(id: params[:artist_id])
        @song = Song.find_by(id: params[:id])
        redirect_to artists_path
    else
      redirect_to artists_path
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
    params.require(:song).permit(:title, :artist_name, :artist_id)
  end
end
