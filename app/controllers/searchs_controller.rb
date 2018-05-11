class SearchsController < ApplicationController

  def index
    @tags = Tag.all
  end

#未完成-----------ここから-----------------------
  def search
    @word = params[:tag_name]

    #空の検索を防ぎたい
    if @word == nil
      redirect_to("/searchs/index")
      flash[:notice] = "文字を入力してください"
    end

    if @tag = Tag.find_by("tag_name like '%" + @word + "%'")
      redirect_to("/searchs/#{params[:tag_name]}")
    else
      redirect_to("/searchs/index")
      flash[:notice] = "検索結果がありませんでした"
    end

  end
#未完成-----------ここまで-----------------------

  def result
    @word = params[:tag_name]
    @tag = Tag.find_by("tag_name like '%" + @word + "%'")
  end

  def show
    @tag = Tag.find_by(tag_name: params[:tag_name])
  end

end
