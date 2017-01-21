require 'nokogiri'
require 'open-uri'

class JamieOliver

  def initialize(keywords)
    @keywords = keywords.split(' ').join('+')
    # @url = get_url
    @url = get_url
  end

  def search
    results = []
    doc = Nokogiri::HTML(open(@url), nil, 'utf-8')
    doc.search('.result.all.recipe').each do |div|
      atributes = {
        name: div.search('h2').text.strip,
        description: '',
        time: div.search('.time').text.strip,
        difficulty: div.search('.difficulty').text.strip,
        img_url: div.search('.img-responsive')
      }
      results << Recipe.new(atributes)
    end
    results
  end

  private

  def get_url
    "http://www.jamieoliver.com/search/?s=#{@keywords}"
  end
end
