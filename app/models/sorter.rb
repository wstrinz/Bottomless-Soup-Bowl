class Sorter < ActiveRecord::Base
  include ScoringAlgorithms

  attr_accessible :name, :algorithm
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

  def score_default(story)
    return 0
    #return (12000 - (Time.now - story.published)/(60 * 60))
  end

  def score_individual(story)
    score = send(algorithm, story)
    if(!score || (!(score.is_a? Integer) && !(score.is_a? Float)) || (score < 0))
      score_default(story)
    else
      score
    end
  end


end
