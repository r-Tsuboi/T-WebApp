class SearchsController < ApplicationController
  before_action :authenticate_user

  def index
    @tags = Tag.all
  end

  def search
    @word = params[:tag_name]

    if params[:tag_name].blank?
      redirect_to("/searchs/index")
      flash[:notice] = "文字を入力してください"
    elsif @tags = Tag.where("tag_name like '%" + @word + "%'")
      redirect_to("/searchs/#{params[:tag_name]}")
    else
      redirect_to("/searchs/index")
      flash[:notice] = "検索結果がありませんでした、違うキーワードを入れてみてください"
    end

  end

  def result
    @word = params[:tag_name]
    @tags = Tag.where("tag_name like '%" + @word + "%'")
    @tags.each do |tag|
      @tag = Tag.find_by(id: tag.id)
      @posts = @tag.search_posts
    end
  end

  def show
    @tag = Tag.find_by(tag_name: params[:tag_name])
  end

end
