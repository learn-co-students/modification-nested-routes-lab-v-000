module SongsHelper

  def artist_select(song,artist)
    if @artist.nil?
      select_tag "song[artist_id]", options_for_select(Artist.all.collect{|a| [a.name, a.id]})
    else
      text_field_tag "song[artist_name]", @artist.name
    end
  end

end
