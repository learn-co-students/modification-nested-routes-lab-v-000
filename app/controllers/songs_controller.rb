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
    if !!params[:artist_id] && !!Artist.find_by(id: params[:artist_id])
      @song = Song.new(artist_id: params[:artist_id])
      @artist = Artist.find_by(id: params[:artist_id])
    elsif !!params[:artist_id] && !Artist.find_by(id: params[:artist_id])
      flash[:alert] = "Artist not found"
      redirect_to artists_path
    else
      @song = Song.new
    end
  end

  def create

    if valid_artist_id
      if !!Artist.find_by(params[:artist_id])
        @song = Song.new(no_name_params)
        if @song.save
          redirect_to artist_song_path(@song.artist_id, @song.id)
        else
          render :new
        end
      else
        flash[:alert] = "Artist not found."
        redirect_to artists_path
      end
    else
      @song = Song.new(song_params)
      if @song.save
        redirect_to @song
      else
        render :new
      end
    end

  end

  def edit
    if !!params[:artist_id] && !Artist.find_by(id: params[:artist_id])
      flash[:alert] = "Artist not found"
      redirect_to artists_path
    elsif song_doesnt_matches_artist
      @artist = Artist.find_by(id: params[:artist_id])
      flash[:alert] = "Song not found."
      redirect_to artist_songs_path(@artist)
    else
      @song = Song.find_by(id: params[:id])
      @artist = Artist.find_by(id: params[:artist_id])
    end
  end

  def update
    @song = Song.find(params[:id])
    if valid_artist_id
      if @song.artist_id = params[:artist_id]
        @song.update(no_name_params)
      else
        redirect_to artist_songs_path(params[:artist_id])
      end
    else
      @song.update(song_params)
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

  def song_doesnt_matches_artist
    if !!Song.find_by(id: params[:id])
      if Song.find_by(id: params[:id]).artist_id != params[:artist_id]
        true
      else
        false
      end
    else
      true
    end
  end

  def valid_artist_id
    params[:song][:artist_id] != "" && params[:song][:artist_id] != nil
  end

  def no_name_params
    params.require(:song).permit(:title, :artist_id)
  end

  def song_params
    params.require(:song).permit(:title, :artist_id, :artist_name)
  end
end
