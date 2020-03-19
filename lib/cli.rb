class CLI

  def call
    Scraper.scrape_imdb
    puts "Welcome to the Box Office Lister"
    puts "Which blockbuster would you like to see today?"
    list_movies
    menu
  end

  def list_movies
    Movies.all.each.with_index(1) do | movie, i |
      puts "#{i}. #{movie.title}"
    end
  end

  def menu
    puts "Please choose a number:"
    input = gets.chomp
    if !input.to_i.between?(1, Movies.all.count)
      puts "Movie not found. Please select a different movie"
      list_movies
      menu
    else
      movie = Movies.all[input.to_i-1]
      display_movie_details(movie)
    end
    puts "Would you like to see another movie?"
    puts "Please enter Y or N"
    another_movie = gets.strip.downcase
    if another_movie == "y"
      list_movies
      menu
    elsif another_movie == "n"
      puts "I hope you have a great time at the cinema!"
      exit
    else
      puts "I didn't get that. Please try again!"
      list_movies
      menu
    end
  end

  def display_movie_details(movie)
    Scraper.scrape_individual_movie(movie)
    puts "Here are the details for #{movie.title}:"
    puts "Rating: #{movie.rating}"
    puts "Runtime: #{movie.runtime}"
    puts "Summary: #{movie.summary}"
  end


end