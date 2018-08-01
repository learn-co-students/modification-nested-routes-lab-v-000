class Song < ActiveRecord::Base
  belongs_to :artist

  def artist_name
    self.try(:artist).try(:name)
  end

  def artist_name=(name)
    artist = Artist.find_or_create_by(name: name)
    self.artist = artist
  end
end



#   it "gets the artist name" do
#     expect(@grid.artist_name).to eq("Daft Punk")
#   end

#   it "can set the artist via name" do
#     song = Song.new(title: "Mad World")
#     song.artist_name = "Tears for Fears"
#     song.save
#     expect(song.artist_name).to eq "Tears for Fears"
#     expect(song.artist.name).to eq "Tears for Fears"
#   end

#   it "finds artist if already exists" do
#     song = Song.create(title: "Around the World", artist_name: "Daft Punk")
#     expect(song.artist_name).to eq "Daft Punk"
#     expect(Artist.all.count).to eq 1
#   end
# end
