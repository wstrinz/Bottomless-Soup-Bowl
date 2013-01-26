module ScoringAlgorithms

  def fbook(story)
    oauth_access_token = "AAACEdEose0cBAF6VMLs3kzMWUHNmqnU2vZAZCJ4DwmXaQYhxtyLjkZBv4rahtem9CJkSZAbfZBQWRqXdrFS3nkhQDUCkXTJlL4rIGRs2ipgZDZD"
    gp = Koala::Facebook::API.new(oauth_access_token)

    shares = gp.fql_query("SELECT total_count FROM link_stat WHERE url='#{story.url}'")[0]
    if shares
      return shares["total_count"]
    end
    return nil
  end

  def time(story)
    return (1200 - (Time.now - story.published)/(60 * 60))
  end

  def fbook_plus_time(story)
    return(time(story) + fbook(story))
  end

end