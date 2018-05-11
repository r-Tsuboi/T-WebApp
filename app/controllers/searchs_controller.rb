class SearchsController < ApplicationController

  def index
    @tags = Tag.all
  end

#未完成-----------ここから-----------------------
  def search
    @word = params[:tag_name]
    if @tag = Tag.find_by("tag_name like '%" + @word + "%'")
      #キーワードに対してtag_nameを適用する
      redirect_to("/searchs/#{@tag.tag_name}/result")
    else
      #検索結果がない仕様のページ
    end
  end
#未完成-----------ここまで-----------------------

  def result
    @tag = Tag.find_by(id: params[:id])
  end

  def show
    @tag = Tag.find_by(id: params[:id])
  end

end
