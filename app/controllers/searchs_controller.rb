class SearchsController < ApplicationController
  before_action :authenticate_user

  def index
    #タグデータのすべてをとってくる
    @tags = Tag.all
  end

  def search
    #フォームから受け取った値を変数に代入
    @word = params[:tag_name]

    #変数に値が入っていないか
    if params[:tag_name].blank?
      #ページを検索ページに返す
      redirect_to("/searchs/index")
      #フラッシュメッセージを表示
      flash[:notice] = "文字を入力してください"
    #入っていた場合はタグテーブルからキーワードに見合うデータを変数に入れる
    elsif @tags = Tag.find_by("tag_name like '%" + @word + "%'")
      #結果ページに飛ぶ
      redirect_to("/searchs/#{params[:tag_name]}")
    #値が入っていたけどタグがなかった場合
    else
      #検索ページに返す
      redirect_to("/searchs/index")
      #フラッシュメッセージを表示
      flash[:notice] = "検索結果がありませんでした、違うキーワードを入れてみてください"
    end

  end

  def result
    #入力された値を変数に代入
    @word = params[:tag_name]
    #タグテーブルからキーワードに見合うデータを変数に入れる
    @tags = Tag.where("tag_name like '%" + @word + "%'")
    #1つのタグに対する投稿データを入れるための空箱
    @tags_posts = []
    #複数のタグを１つずつ処理にかける
    @tags.each do |tag|
      #タグのidを参照して変数に代入
      @tag =  Tag.find_by(id: tag.id)
      #タグのデータを１つずつ配列に入れていく
      @tags_posts.push(tag)
    end
  end

  def show
    #タグの名前をとってきて変数に代入
    @tag = Tag.find_by(tag_name: params[:tag_name])
  end

end
