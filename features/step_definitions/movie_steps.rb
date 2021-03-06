# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie);
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  
  assert /.*#{e1}.*#{e2}.*/m.match(page.body)

  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.

end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(",").each do |rating| 
    if uncheck
      uncheck("ratings_" + rating)
    else 
      check("ratings_" + rating)
    end
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

Then /I should see movies with ratings: (.*)/ do |rating_list|
  rating_list.split(",").each do |rating| 
    movies = Movie.find(:all, :conditions => {:rating => rating})
    movies.each do |movie|
      #puts(movie.title)
      assert page.has_content?(movie.title) 
      #assert page.has_content?(movie.release_date)  
    end
  end
end

Then /I should not see movies with ratings: (.*)/ do |rating_list|
  rating_list.split(",").each do |rating| 
    movies = Movie.find(:all, :conditions => {:rating => rating})
    movies.each do |movie|
      #puts(movie.title)
      assert page.has_no_content?(movie.title) 
      #assert page.has_no_content?(movie.release_date) 
    end
  end
end

When /I check all movie ratings/ do 
  Movie.all_ratings.each do |rating|
    check("ratings_" + rating)
  end
end
Then /I should see all the movies/ do
  movies = Movie.all
  movies.each do |movie|
    #puts(movie.title)
    assert page.has_content?(movie.title) 
    #assert page.has_content?(movie.release_date)  
  end

  # Make sure that all the movies in the app are visible in the table
end


