module SongsHelper
  def artist_id_field(song)hidden_field_tag "song[artist_id]", song.artist_id
  end
end
