require 'open-uri'
require 'nokogiri'

class LinksController < ApplicationController
  def recommend
    link = Link.recommend
    render :json => link
  end
end
