module SongsHelper

  def artist_select(song)
    if song.artist.nil?
      select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
    else
      label_tag song.artist.name
      hidden_field_tag "song[artist_id]", song.artist_id
    end
  end

end
