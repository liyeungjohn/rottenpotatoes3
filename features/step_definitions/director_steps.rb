#Scenario: add director to existing movie
Then /^the director of "(.*)" should be "(.*)"$/ do |movieTitle, movieDirector|
    curr = Movie.find(:first, :conditions => {:title => movieTitle}) 
    assert curr.director == movieDirector
end
     
