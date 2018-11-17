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
      redirect_to artists_path
    else
      @song = Song.new(artist_id: params[:artist_id])
    end
  end

  def create
    @song = Song.new(song_params)
    @song.artist_id = params[:song][:artist_id]
    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    y = false
    Song.all.each do |s|
      if s.id == params[:id].to_i
        y = true
      end
    end
    if y == true
      @song = Song.find(params[:id])
    end


    x = false
    Artist.all.each do |art|
      if art.id == params[:artist_id].to_i
        x = true
      end
    end
    if x == true
      @artist = Artist.find(params[:artist_id])
    end

    if x == false
      if params[:artist_id] == nil
        x = true
      end
    end


    if x == false
      redirect_to artists_path
    elsif y == false
      redirect_to artist_songs_path(@artist)
    else
     render :edit
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

