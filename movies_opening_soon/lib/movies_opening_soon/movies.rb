class MoviesOpeningSoon::Movies
  @@all = []

  attr_accessor :name, :theaters, :length, :rating, :genre, :bio, :url, :review_score

  def initialize(movie_hash)
    @name = movie_hash[:name]
    @url = movie_hash[:url]
    @@all << self
  end

  def self.create_from_page(movie_array)
    movie_array.each do |movie|
      MoviesOpeningSoon::Movies.new(movie)
    end
  end

  def self.find(number)
    @@all[number - 1]
  end

  def add_movie_details(attribute_hash)
    #@theaters = attribute_hash[:theaters]
    @length = attribute_hash[:length]
    @rating = attribute_hash[:rating]
    @review_score = attribute_hash[:review_score]
    @genre = attribute_hash[:genre]
    @bio = attribute_hash[:bio]
  end

  def self.all
    @@all
  end

end
