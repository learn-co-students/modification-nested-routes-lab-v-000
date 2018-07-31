module SongsHelper
  def artist_select(selection_group, song)
    if song.artist.nil?
      select_tag "song[artist_id]", options_from_collection_for_select(selection_group, :id, :name)
    else
      hidden_field_tag "song[artist_id]", song.artist_id
    end
  end
end
