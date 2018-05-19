module SongsHelper

  def artist_select(song, artists)
    if params[:artist_id]
      hidden_field_tag "song[artist_id]", song.artist_id
      "<p><%= song.artist.name %></p>".html_safe
    else
      select_tag "song[artist_id]", options_from_collection_for_select(artists, :id, :name) 
    end
  end

end
