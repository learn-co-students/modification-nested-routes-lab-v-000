module ArtistsHelper
  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end

  def artist_select(song, artist)
    # if artist   
      # <%= f.hidden_field :artist_id %>
      # Artist name: <%= @artist.name %>
  # <% else %>
    # <!--
      # <%#= f.label :artist_name %> <!-- So, despite the Song#artist_name method, this isn't needed.
      # <%#= f.text_field :artist_name %> <!-- Or this, for that matter.
    # -->
# 
    # <%= f.label :artist_id, "Artist name" %>
    # <%= f.select :artist_id, options_from_collection_for_select(Artist.all, :id, :name) %>
  # <% end %>
  end
end
