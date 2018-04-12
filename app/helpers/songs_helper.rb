module SongsHelper
  def artist_select(song, editing_through_nested_routing)
    if !editing_through_nested_routing
      select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
    else
      content_tag(:p) do
        song.artist.name
      end
    end
  end
end
