module ArtistsHelper
  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end

  def artist_select(artist, song)
    # select_tag(name, option_tags = nil, options = {})
    # select_tag "people", options_from_collection_for_select(@people, "id", "name")
    # <select id="people" name="people"><option value="1">David</option></select>
    # binding.pry
    select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)

    # <%= select_tag "date", options_for_select(["Today", "Old News"]), include_blank: true %>
  end
end
