class MovieScraper

  def self.scrape_movie_overview(overview_url, zip)
    html = open(overview_url)
    doc = Nokogiri::HTML(html)
    movie_list = doc.css(".lister-item")
    movie_array = []
    movie_list.each do |movie|
      movie_hash = {}
      movie_hash[:name] = movie.css(".title").text.to_s
      movie_hash[:url] = ("https://www.imdb.com" + movie.css("a").attribute("href").value.gsub("?ref_=shlc_li_i","") + "US/" + zip).chomp.to_s
      movie_array << movie_hash
    end
    movie_array
  end

  def self.scrape_movie_details(movie_url)
    #:theaters
    movie_hash = {}
    html = open(movie_url)
    doc = Nokogiri::HTML(html)
    details = doc.css(".cert-runtime-genre")

    if doc.search(".cert-runtime-genre img").size > 0
      movie_hash[:rating] = details.css("img").attribute("title").value.to_s
    else
        movie_hash[:rating] = "unknown"
    end
    movie_hash[:length] = details.css("time").text.to_s
    movie_hash[:genre] = details.css("span").text.to_s
    movie_hash[:bio] = doc.css(".outline").text.to_s.gsub(/\n/,"").strip.to_s
    movie_hash[:review_score] = doc.css(".rating_txt .rating-rating").text.to_s
#    theaters = []
#    theater_list = doc.css(".list")
#
#    movie_hash[:theaters] = theaters

    movie_hash
  end

end
