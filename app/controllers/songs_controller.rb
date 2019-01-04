class SongsController < ApplicationController
  def index
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found."
      else
        @songs = @artist.songs
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      if Artist.exists?(params[:artist_id])
        @artist = Artist.find(params[:artist_id])
        if @artist.songs.exists?(params[:id])
          @song = @artist.songs.find(params[:id])
        else
          redirect_to artist_songs_path, alert: "Song not found."
        end
      else
        redirect_to artists_path, alert: "Artist not found."
      end
    else
      @artists = Artist.all
      @song = Song.find(params[:id])
    end
  end

  def new
    if params[:artist_id]
      if Artist.exists?(params[:artist_id])
        @song = Song.new(artist_id: params[:artist_id])
      else
        redirect_to artists_path, alert: "Artist does not exist"
      end
    else
      @song = Song.new
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
    if params[:artist_id]
      if Artist.exists?(params[:artist_id])
        @artist = Artist.find(params[:artist_id])
        if @artist.songs.exists?(params[:id])
          @song = @artist.songs.find(params[:id])
        else
          redirect_to artist_songs_path, alert: "Song does not exist"
        end
      else
        redirect_to artists_path, alert: "Author does not exist"
      end
    else
      @artists = Artist.all
      @song = Song.find(params[:id])
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

