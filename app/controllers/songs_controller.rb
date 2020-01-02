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
      redirect_to artists_path, alert: "Artist not found"
    else
      @song = Song.new(artist_id: params[:artist_id])
      @artist = @song.artist
      # Remember that if params[:artist_id] is nil, then @song.artist_id will be nil anyway,
      # just as though I had called Song.new() instead.
      # By the same token, @artist can be nil as well.
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
      @artist = Artist.find_by_id(params[:artist_id]) # Limit the SQL queries as much as possible.

      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
        # Weird bug here: If I accidentally say artist_path, it redirects to /artists/:id, where :id is the SONG'S id.
      else
        @song = @artist.songs.find_by_id(params[:id])
        redirect_to artist_songs_path(@artist), alert: "Song not found" if @song.nil?
        # Once I figure out how to write controller-specific helpers, I can probably refactor the line above.
        
        # And for some reason, redirecting doesn't permanently exit this method, so I can't do this:
          # redirect_to artists_path, alert: "Artist not found" if @artist.nil?
          # @song = @artist.songs.find_by_id(params[:id])
          # redirect_to artist_songs_path(@artist), alert: "Song not found" if @song.nil?
        # If @artist is nil, @song = @artist.songs... breaks despite the redirect above it.
      end
    else 
      @song = Song.find(params[:id])
      # Ideally, I would redirect to /songs if the song doesn't exist, but this code is complicated enough.
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

