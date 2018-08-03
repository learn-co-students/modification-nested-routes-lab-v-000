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

  def new #if accessed through an artist, we will need to link artist to song ?
    # check if artist_id as id of an artist exists for the new song(aka: does this artist exist?)
    if params[:artist_id] && !Artist.exists?(params[:artist_id])
      redirect_to artists_path, alert: "Artist not found"
    else
      @song = Song.new(artist_id: params[:artist_id]) #include artist_id if it exists during creation
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
    if params[:artist_id] #if routed via artist paths 
      artist = Artist.find_by(id: params[:artist_id])
      if artist.nil? #if there is no artist found by id (artist_id)
        redirect_to artists_path, alert: "Artist not found"
      else #if there IS an artist
        @song = artist.songs.find_by(id: params[:id])
        redirect_to artist_songs_path(artist), alert: "Song not found" if @song.nil? #redirect if !song
      end
    else #if there is no artist_id involved/ song made normally and not via artist paths
      @song = Song.find_by(id: params[:id])
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
