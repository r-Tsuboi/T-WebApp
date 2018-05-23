class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}

  def index
    #ユーザのデータをすべて取ってくる
    @users = User.all
  end

  def show
    #ユーザIDを変数に代入
    @user = User.find_by(id: params[:id])
  end

  def new
    #新しくユーザを作る
    @user = User.new
  end

  def create
    #ユーザを新規作成（受け取った値を各カラムに入れる）
    @user = User.new(name: params[:name], email: params[:email],
                    image_name:"default_user.jpg", password: params[:password])
    #ユーザが保存できた場合
    if @user.save
      #ログインしているユーザを先ほど新規作成したユーザにする
      session[:user_id] = @user.id
      #フラッシュを表示
      flash[:notice] = "はじめまして、ユーザー登録が完了しました。"
      #投稿一覧ページにページ移動
      redirect_to("/posts/index")
    #できなかった場合
    else
      #エラーメッセージを追加
      @error_message = "ユーザー登録ができませんでした。"
      #新規ユーザ登録ページに返す
      render("users/new")
    end
  end

  def edit
    #ユーザデータをIDから参照して変数に代入
    @user = User.find_by(id: params[:id])
  end

  def update
    #ユーザデータをIDから参照して変数に代入
    @user = User.find_by(id: params[:id])
    #受け取った値をユーザ名カラムに入れる
    @user.name = params[:name]
    #受け取った値をEメールカラムに入れる
    @user.email = params[:email]
    #受け取った値をパスワードカラムに入れる
    @user.password = params[:password]

    #ユーザ画像を受け取った場合
    if params[:image]
      #ユーザ画像を定義して変数に代入
      @user.image_name ="#{@user.id}.jpg"
      #受け取った値を変数に代入
      image = params[:image]
      #受け取ったデータを画像ファイルとして保存する
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    #ユーザデータが保存できたとき
    if @user.save
      #フラッシュメッセージを表示
      flash[:notice] = "変更が完了しました"
      #ユーザ詳細画面にページを移動
      redirect_to("/users/#{@user.id}")
    #できなかった場合
    else
      #ユーザ編集ページに返す
      render("users/edit")
    end
  end

  def login_form
  end

  def login
    #入力された値から、ユーザデータを見つける
    @user = User.find_by(email: params[:email],password: params[:password])

    #ユーザが存在したら
    if @user
      #ユーザをログイン状態にする
      session[:user_id] = @user.id
      #フラッシュメッセージを表示
      flash[:notice] = "こんにちは、ログインが完了しました"
      #ユーザ詳細ページにページ移動
      redirect_to("/users/#{@user.id}")
    #なかった場合
    else
      #エラーメッセージを表示
      @error_message = "メールアドレスまたはパスワードが間違っています"
      #ログインページに返す
      render("users/login_form")
    end
  end

  def logout
    #ログインユーザをなしにする
    session[:user_id] = nil
    #フラッシュメッセージを表示
    flash[:notice] = "さようなら、また会いましょう"
    #ログインページにページ移動
    redirect_to("/login")
  end

  def likes
    #ユーザIDを変数に代入
    @user = User.find_by(id: params[:id])
    #ユーザのデータをいいねのテーブルに反映
    @like_posts = @user.like_posts
  end

  def sees
    #ユーザIDを変数に代入
    @user = User.find_by(id: params[:id])
    #ユーザのデータをわかるテーブルに反映
    @see_posts = @user.see_posts
  end


end
