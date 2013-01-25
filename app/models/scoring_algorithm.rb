class ScoringAlgorithm < ActiveRecord::Base
  attr_accessible :name
  belongs_to :flavor

  def score(story)
    if (story.is_a? Array)
      story.each do |s|
        score_individual(s)
      end
    else
      score_individual(story)
    end
  end

  def score_individual(story)
    return (12000 - (Time.now - story.published)/(60 * 60))
  end
end
