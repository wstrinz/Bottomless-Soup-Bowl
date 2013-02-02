module ScoringAlgorithms

  def fbook(story)
    oauth_access_token = "AAACEdEose0cBAJMfJGFBFN49UjQNqwMOmWfwRuzZAMFCOUUkZAfDZA1FUmY0ceqn9ZAV3VUeobCd9girgpRbZB5zLX2tNfdjGcmT4LSrMigZDZD"
    gp = Koala::Facebook::API.new(oauth_access_token)

    shares = gp.fql_query("SELECT total_count FROM link_stat WHERE url='#{story.url}'")[0]
    if shares
      return shares["total_count"]
    end
    return 0
  end

  def time(story)
    return (1200 - (Time.now - story.published)/(60 * 60))
  end

  def fbook_plus_time(story)
    return(time(story) + fbook(story))
  end

end