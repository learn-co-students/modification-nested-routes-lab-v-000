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
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
      @song = Song.new(artist_id: params[:artist_id])
    end
    else
      @song = Song.new
    end
  end

  def create
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
        @song = Song.create(song_params)
        redirect_to artist_song_path(@song)
      end
    else
      @song = Song.create(song_params)
      redirect_to @song
    end
  end

  def edit
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      #artist-validation
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found."
      else
      @song = @artist.songs.find_by(id: params[:id])
      #song-validation
      if @song.nil?
        redirect_to artist_songs_path
      end 
    end
    else
      @song = Song.find(params[:id])
      @artists = Artist.all
    end
  end

  def update
    @song = Song.find(params[:id])
    if params[:artist_id] && song_params[:artist_name] == "" || song_params[:artist_name] == nil
      redirect_to artists_path
    elsif
      @artist = Artist.find_by(id: params[:artist_id])
        if !@artist.songs.include?(@song)
          redirect_to artist_songs_path
        else
          @song.update(song_params)
          if @song.save
            redirect_to @song
          else
            render :edit
        end
      end
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
