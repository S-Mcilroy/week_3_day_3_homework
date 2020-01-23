require('pg')
require_relative('../db/sql_runner.rb')

class Album

  attr_accessor :title, :genre
  attr_reader :id, :artist_id

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums (title, genre, artist_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@title, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def update()
    sql = "UPDATE albums SET (title, genre, artist_id) = ($1, $2, $3) WHERE id = $4"
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    result = SqlRunner.run(sql)
    return result.map{|album| Album.new(album)}
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return result.map{|album| Album.new(album)} if result.any?
    return nil
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    result = SqlRunner.run(sql, values)
    return Artist.new(result.first)
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

end
