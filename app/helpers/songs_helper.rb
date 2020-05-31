module SongsHelper

  def artist_id_field(song)
    if song.artist.nil? #if there is no artist, offer a selection
      select_tag "song[author_id]", options_from_colleciton_for_select(Artist.all, :id, :name)
    else #if song has an artist, hide field for author_id to persist through navigation
      hidden_field_tag "song[author_id]", song.author_id
    end
  end

end
