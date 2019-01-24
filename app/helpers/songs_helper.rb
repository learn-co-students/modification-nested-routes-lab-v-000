module SongsHelper

  def artist_select(song, var)
    if var.nil?
      song.artist_name = ""
      select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name), prompt: "Select Artist"
    end 
  end


end
