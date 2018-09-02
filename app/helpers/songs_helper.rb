module SongsHelper

  def artist_select(song, artist)
    if !!params[:artist_id]
      artist.name
    elsif !!song.artist
      song.artist.name
    else
      collection_select(:song, :artist_id, Artist.all, :id, :name, {include_blank: ""})
    end
  end

end
