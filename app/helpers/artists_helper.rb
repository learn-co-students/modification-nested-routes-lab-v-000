module ArtistsHelper
  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end

  def artist_select(song, artist)
    select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, "id", "name"), include_blank: true 
  end
end

#select_tag(name, option_tags = nil, options = {}) public
#options_from_collection_for_select(collection, value_method, text_method, selected = nil)

#if someone edits a song directly via songs/:id/edit 
#the pulldown artist menu will assign an artist
#artist_id would be added to the song

#params[:song][:artist_id] - hidden artist_id passed through with the form 