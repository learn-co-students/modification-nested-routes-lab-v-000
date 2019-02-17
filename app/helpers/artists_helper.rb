module ArtistsHelper

  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end

  def artist_select(artist, song)
    if song.artist.nil?
      select_tag "song[artist_id]", options_from_collection_for_select(:artist_name, Artist.all, :id, :name)
    else
      hidden_field_tag "song[artist_id]", song.artist_id
    end
  end

end

#it "displays a link to the artist page if artist not empty" do
#  expect(helper.display_artist(@song)).to include(artist_path(@artist))
#  expect(helper.display_artist(@song)).to include(@artist.name)
#end
