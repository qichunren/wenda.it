# encoding: utf-8  
class TagsController < ApplicationController

  def index
    @tags = Tag.paginate :page => params[:page]
    @youareat = "tags"
  end
  
  def search
    @tags = Tag.search(params[:keyword])
    render :layout => false
  end
  
end