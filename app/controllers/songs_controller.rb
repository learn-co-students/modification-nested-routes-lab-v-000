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
		artist_id_ = params[:artist_id]
		if artist_id_	
			artist_ = Artist.find_by(id: params[:artist_id])
			if artist_
				@song = Song.new(artist_id: artist_id_)
			else
				redirect_to artists_path
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
		artist_id_ = params[:artist_id]
		artist_ = nil
		artist_ = Artist.find_by(id: params[:artist_id]) if artist_id_
		
		if !artist_ && artist_id_
			redirect_to artists_path
		elsif artist_
			@song = artist_.songs.find_by(id: params[:id])
			@display_artists = false
			redirect_to artist_songs_path(artist_) if !@song
		else
			@song = Song.find_by(id: params[:id])
			@display_artists = true
		end
  end

  def update
		#binding.pry
    @song = Song.find(params[:id])
    @song.update(song_params)

		artist_id_ = params[:artist_id]
		if artist_id_
			artist_ = Artist.find_by(id: params[:artist_id])
		else 
			artist_ = nil
		end	

		if !artist_ && artist_id_
			redirect_to artists_path
		elsif @song.save
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

