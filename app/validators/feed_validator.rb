class FeedValidator < ActiveModel::Validator
  def validate(record)
    unless Feedzirra::Feed.fetch_and_parse(record.url)
      record.errors[:base] << "Could not load feed at #{record.url}"
    end
  end

end
