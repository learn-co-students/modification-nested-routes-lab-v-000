module SongsHelper
  def artist_select(artist, song)
    if artist.nil?
      select_tag("song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name), {include_blank: true})
    else
      hidden_field_tag("song[artist_id]", song.artist_id)
    end
    # if artist
    #   artist.name
    # else
    #   select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
    # end
  end
end
