class SearchsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def search
    @word = params[:tag_name]

    if params[:tag_name].blank?
      redirect_to("/searchs/index")
      flash[:notice] = "文字を入力してください"

    elsif @tag = Tag.find_by("tag_name like '%" + @word + "%'")
      redirect_to("/searchs/#{params[:tag_name]}")

    else
      redirect_to("/searchs/index")
      flash[:notice] = "検索結果がありませんでした"
    end

  end

  def result
    @word = params[:tag_name]
    @tag = Tag.find_by("tag_name like '%" + @word + "%'")
  end

  def show
    @tag = Tag.find_by(tag_name: params[:tag_name])
  end

end
