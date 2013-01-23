class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def import_feeds_from_xml(infile)
    urls = []

    doc = Nokogiri::XML(infile)
    doc.xpath("//outline").each do |ent|
      if ent.attribute("xmlUrl")
        urls.push(ent.attribute("xmlUrl").value)
      end
    end

    urls.each do |u|

      current_user.bsb_feeds.create!(url: u)

      ## some debug code
      # #fd = Feedzirra::Feed.fetch_and_parse(u)
      # fd = u
      # if !fd || (fd.is_a? Fixnum)
      #   "err:#{u}"
      # else
      #   #fd.title
      #   u
      # end

    end
  end
end
