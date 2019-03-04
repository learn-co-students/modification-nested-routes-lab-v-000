module SongsHelper

def artist_select(song, artist)
    if artist.nil?
      select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
    else
      select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name, song.artist_id)
    end
  end

end
