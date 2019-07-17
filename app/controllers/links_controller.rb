require 'open-uri'
require 'nokogiri'

class LinksController < ApplicationController
  def create
    @link = Link.create!(url: params[:url])

    if @link.valid?
      page = Nokogiri::HTML.parse(open(@link.url).read, @link.url)
      @link.title = parse_title(page)
      @link.description = parse_description(page)
      @link.image = parse_image(page)

      @link.save
    end

    head :created
  end

  def parse_title(page)
    if page.css('//meta[property="og:title"]/@content').empty?
      page.title.to_s
    else
      page.css('//meta[property="og:title"]/@content').to_s
    end
  end

  def parse_description(page)
    if page.css('//meta[property="og:description"]/@content').empty?
      page.css('//meta[name$="escription"]/@content').to_s
    else
      page.css('//meta[property="og:description"]/@content').to_s
    end
  end

  def parse_image(page)
    page.css('//meta[property="og:image"]/@content').to_s
  end
end
