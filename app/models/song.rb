class Song < ActiveRecord::Base
  belongs_to :artist

  def artist_name
    self.try(:artist).try(:name)
  end

  def artist_name=(name)
    artist = Artist.find_or_create_by(name: name)
    self.artist_id = artist.id
  end

  # def artist_id(id)
  #   if self.artist_id == "" || self.artist_id == nil
  #
  #   end
  # end

end
