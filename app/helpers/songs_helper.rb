module SongsHelper
  def artist_select(f, song)
    if song.artist.nil?
      f.label :artist_name
      select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
    else
      hidden_field_tag "song[artist_id], song.artist_id"
    end
  end
end
