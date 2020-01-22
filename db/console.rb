require("pry")
require_relative("../models/album")
require_relative("../models/artist")

Album.delete_all
Artist.delete_all

artist1 = Artist.new(
  {
    'name' => 'Linkin Park'
  }
)

artist2 = Artist.new(
  {
    'name' => 'Daft Punk'
  }
)

artist1.save
artist2.save

album1 = Album.new(
  {
    'title' => 'Hybrid Theory',
    'genre' => 'Rock',
    'artist_id' => artist1.id
  }
)

album2 = Album.new(
  {
    'title' => 'Minutes to Midnight',
    'genre' => 'Rock',
    'artist_id' => artist1.id
  }
)

album3 = Album.new(
  {
    'title' => 'Interstella 5555',
    'genre' => 'House',
    'artist_id' => artist2.id
  }
)

album1.save
album2.save
album3.save

album2.title = 'Meteora'
album2.update


binding.pry
nil
