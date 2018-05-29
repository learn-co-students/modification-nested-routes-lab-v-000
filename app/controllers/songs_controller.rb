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
    if params[:artist_id] && !Artist.exists?(params[:artist_id])
      redirect_to artists_path, alert: "Artist not found."
    else
      @song = Song.new(artist_id: params[:artist_id])
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
    #when we are editing the song, we need to make sure the artist is valid and the post actually belongs to the correct author.
    if params[:artist_id]
    #if navigating thru the nested route artists/1/songs/2/edit
      artist = Artist.find_by(id: params[:artist_id])
      #find the artist and assign
      if artist.nil?
        #if the artist does not exist
        redirect_to artists_path, alert: "Artist not found."
      else
      #if we have the artist
        @song = artist.songs.find_by(id: params[:id])
        #search for the song to edit through the artists/songs and assign
        redirect_to artist_songs_path(artist), alert: "Song not found." if @song.nil?
        #redirect to the artists songs (their songs index page) if the song doesn't exist
      end
    else
    #if navigating through the regular (unnested route such as songs/2/edit)
      @song = Song.find(params[:id])
      #assign the song variable here.
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
