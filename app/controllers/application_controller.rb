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

    urls
  end
end
