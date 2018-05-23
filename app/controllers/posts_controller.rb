class PostsController < ApplicationController
  before_action :authenticate_user

  def index
    #投稿データをすべて持ってくる
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    #見たい投稿IDを変数に代入
    @post = Post.find_by(id: params[:id])
    #投稿IDからユーザデータを取り出す
    @user = User.find_by(id: @post.user_id)
    #投稿データからタグを参照する
    @search_tags = @post.search_tags
  end

  def new
    #投稿を新規作成する
    @post = Post.new
    #タグを新規登録する
    @tag = Tag.new
    #検索テーブルに新規登録する
    @search = Search.new
  end

  def create
    #入力された値から各カラムにデータを入れる
    @post = Post.new(title: params[:title], content: params[:content],
                      post_image: params[:post_image], user_id:@current_user.id)
    #タイトルに入力された値をカラムに追加
    @post.title = params[:title]
    #投稿内容に入力された値をカラムに追加
    @post.content = params[:content]
    #投稿データを保存する
    @post.save

    #投稿に画像が入っていた場合
    if @post.post_image != nil
      #投稿画像を変数に代入
      @post.post_image ="#{@post.id}.jpg"
      #入力された値を変数に代入
      image = params[:post_image]
      #投稿されたデータを画像ファイルとして保存
      File.binwrite("public/post_image/#{@post.post_image}", image.read)
    #入っていなかった場合
    else
      #デフォルトの画像をカラムに追加
      @post.post_image = "default_post.jpg"
    end

    #投稿が保存できた場合
    if @post.save
      #投稿一覧ページにページ移動
      redirect_to("/posts/index")
      #できなかった場合
    else
      #エラーメッセージを表示
      @error_message = "投稿できませんでした"
      #新規投稿画面に返す
      render("posts/new")
    end

    #入力された値を変数に代入
    @tag = params[:tag_name]
    #入力された文字列からスペースを消す
    @base_tags = @tag.delete("　")
    #入力された文字列をカンマで区切って配列に入れる
    @tags = @base_tags.split(",")

    #タグの配列を一つ一つし処理する
    @tags.each do |tag|
      #入力されたタグが存在するか
      if  Tag.exists?(tag_name: tag)
        #あったら、テーブルから参照して持ってくる
        @tag = Tag.find_by(tag_name: tag)
        #なかったら
      else
        #新しく入力された値をカラムに追加する
        @tag = Tag.new(tag_name: tag)
        #タグを保存する
        @tag.save
      end

      #検索テーブルを作られた投稿データをタグデータから作成する
      @search = Search.new(post_id: params[:post_id], tag_id: params[:tag_id])
      #投稿IDには新規作成した投稿のIDをカラムに追加
      @search.post_id = @post.id
      #タグIDにはタグのIDをカラムに追加
      @search.tag_id = @tag.id
      #保存
      @search.save
    end
  end


  def edit
    #編集したい投稿のIDを変数に代入
    @post = Post.find_by(id: params[:id])
    #検索テーブルから投稿についているタグを参照
    @search_tags = @post.search_tags

  end

  def update
    #編集したい投稿のIDを変数に代入
    @post = Post.find_by(id: params[:id])
    #入力された値をタイトルカラムに追加
    @post.title = params[:title]
    #入力された値を投稿内容カラムに追加
    @post.content = params[:content]

    #画像が登録された場合
    if params[:image]
      #投稿画像カラムに画像名を定義
      @post.post_image ="#{@post.id}.jpg"
      #入力された値を変数に代入
      image = params[:image]
      #入力されたものを画像データとして保存できるようにする
      File.binwrite("public/post_image/#{@post.post_image}", image.read)
    end

    #投稿が保存されたら
    if @post.save
      #投稿一覧画面にページを移動
      redirect_to("/posts/index")
    #保存されなかったら
    else
      #投稿編集画面に返す
      render("posts/edit")
    end

    #チェックボックスからのデータを変数に代入
    @checked_tags = Tag.where(id: params[:now_tags])
    #タグの配列を一つずつ処理する
    @checked_tags.each do |tag|
      #タグデータから検索テーブルを取得
      @delete_tag = Search.find_by(post_id: @post.id, tag_id: tag.id)
      #取得したデータを削除
      @delete_tag.destroy
    end

    #入力された値を変数に代入
    @tag = params[:tag_name]
    #文字列からスペースを排除
    @base_tags = @tag.delete("　")
    #文字列をカンマで区切り、一つずつ配列化する
    @tags = @base_tags.split(",")

    #タグの配列を一つずつ処理する
    @tags.each do |tag|
      #タグがそんざいするか
      if  Tag.exists?(tag_name: tag)
        #あったら、タグを見つけ出す
        @tag = Tag.find_by(tag_name: tag)
        #なかったら
      else
        #入力された値をカラムに追加
        @tag = Tag.new(tag_name: tag)
        #保存
        @tag.save
      end

      #タグのデータと投稿のデータから検索テーブルを作成
      @search = Search.new(post_id: params[:post_id], tag_id: params[:tag_id])
      #投稿データから投稿IDカラムを作成
      @search.post_id = @post.id
      #タグデータからタグIDカラムを作成
      @search.tag_id = @tag.id
      #保存
      @search.save
    end

  end

  def destroy
    #消したい投稿データを取得
    @post = Post.find_by(id: params[:id])
    #消す
    @post.destroy

    #削除した投稿データから関連する検索データを取得
    @searchs = Search.where(post_id: @post.id)
    #複数のデータを一つずつ処理
    @searchs.each do |search|
      #削除
      search.destroy
    end

    #削除した投稿から関連するいいねデータを取得
    @likes = Like.where(post_id: @post.id)
    #複数のデータを一つずつ処理
    @likes.each do |like|
      #削除
      like.destroy
    end

    #削除した投稿から関連するわかるデータを取得
    @sees = See.where(post_id: @post.id)
    #複数データを一つずつ処理
    @sees.each do |see|
      #削除
      see.destroy
    end

    #フラッシュメッセージを表示
    flash[:notice] = "投稿を削除しました"
    #投稿一覧画面にページ移動
    redirect_to("/posts/index")
  end

end
