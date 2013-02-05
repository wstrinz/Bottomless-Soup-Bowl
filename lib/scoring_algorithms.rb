module ScoringAlgorithms

  def fbook(story)
    oauth_access_token = "AAACEdEose0cBAK4y7ZBIMHCn4RYHHtghBZBLWFmNpAulUMkZCApBiCwngVSh0VVUNVuH7RGE9yBT4IFy86u1qsYcG6uRpxKZCbw1ADsgyAZDZD"
    gp = Koala::Facebook::API.new(oauth_access_token)

    shares = gp.fql_query("SELECT total_count FROM link_stat WHERE url='#{story.url}'")[0]
    if shares
      return shares["total_count"]
    end
    return 0
  end

  def time(story)
    return (1000 - (Time.now - story.published)/(60 * 60))
  end

  def fbook_plus_time(story)
    return(time(story) + fbook(story))
  end

end