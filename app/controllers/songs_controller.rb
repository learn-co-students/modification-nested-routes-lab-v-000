class SongsController < ApplicationController
  def new
    # @artist = Artist.find_or_create_by(id: params[:artist_id])
    # @song = @artist.songs.find_by(id: :artist_id) 
    if params[:artist_id] && !Artist.exists?(id: params[:artist_id])
      redirect_to artists_path, alert: "Artist not found"
    else
      @song = Song.new(id: params[:artist_id])
      #why dont' we need to have @song = Song.new without parameter that
      # indicate an association with artists?
    end
  
  end

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

  def create
    #create gives strong paramaters to instance made by the #new action here
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    if params(:artist_id)
      author = Author.find_by(id: params[:author_id])
      if author.nil?
        
      end
    else
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
    params.require(:song).permit(:title, :artist_name, :author_id)
    # binding.pry
  end
end

