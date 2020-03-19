class Scraper

  IMBD_URL = "https://www.imdb.com"

  def self.scrape_imdb
    html = open(IMBD_URL)
    # open our url
    doc = Nokogiri::HTML(html)
    # use nokogiri to parse our url
    doc.css(".boxOffice").css("._30mfPTbFg9-M7bjbyKJ6ie").each do |movie| 
      title = movie.css(".boxOfficeTitleLink").css('div')[0].text
      url = movie.css(".boxOfficeTitleLink").attr('href').value
      Movies.new(title, url)
    end
    # loop through each of our elements and pull out the title and the url
    # create a new movie object with the title and the url for each movie
  end

  def self.scrape_individual_movie(movie)
    html = open(IMBD_URL+movie.url)
    binding.pry
    doc = Nokogiri::HTML(html)
    movie.rating = doc.css(".subtext").text.split("\n")[1].strip
    movie.runtime = doc.css(".subtext").text.split("\n")[3].strip
    movie.summary = doc.css(".summary_text").text.strip
  end

end