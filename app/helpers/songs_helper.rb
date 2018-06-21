module SongsHelper
#
#   def display_artist(song)
#       link_to song.artist_name, edit_song_path(song)
#       hidden_field_tag "song[artist_id]", song.artist_id
#   end
#   #
#   # def artist_select(song)
#   #   if song.artist.nil?
#   #     select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
#   #   else
#   #     display_artist(song)
#   #   end
#   # end
#
#   def artist_select(song)
#     form_for song  do |f|
#       if song.artist.nil?
#         f.collection_select :artist_id, Artist.all, :id, :name
#       else
#         display_artist(song)
#       end
#     end
#   end
# end
  def artist_select(artist, song)
    if artist
      artist.name
    else
      select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
    end
  end
end
