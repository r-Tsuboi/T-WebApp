class SearchsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def search
    @word = params[:tag_name]
    @tags = Tag.where("tag_name like '%" + @word + "%'")
    redirect_to("/searchs/#{@tags.id}/result")
  end

  def result
    @tag = Tag.find_by(id: params[:id])
  end

  def show
    @tag = Tag.find_by(id: params[:id])
  end

end