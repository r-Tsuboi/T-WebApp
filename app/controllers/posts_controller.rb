class PostsController < ApplicationController
  before_action :authenticate_user

  def index
    #投稿データをすべて持ってくる
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    #投稿IDを変数に代入
    @post = Post.find_by(id: params[:id])
    #投稿IDからユーザデータを取り出す
    @user = User.find_by(id: @post.user_id)
    #投稿データからタグを参照する
    @search_tags = @post.search_tags
  end

  def new
    @post = Post.new
    @tag = Tag.new
    @search = Search.new
  end

  def create
    @post = Post.new(title: params[:title], content: params[:content],
                      post_image: params[:post_image], user_id:@current_user.id)
    @post.title = params[:title]
    @post.content = params[:content]
    @post.post_image = params[:post_image]
    @post.save

    if @post.post_image != nil
      @post.post_image ="#{@post.id}.jpg"
      image = params[:post_image]
      File.binwrite("public/post_image/#{@post.post_image}", image.read)
    else
      @post.post_image = "default_post.jpg"
    end

    if @post.save
      redirect_to("/posts/index")
    else
      @error_message = "投稿できませんでした"
      render("posts/new")
    end

    @tag = params[:tag_name]
    @base_tags = @tag.delete("　")
    @tags = @base_tags.split(",")

    @tags.each do |tag|
      if  Tag.exists?(tag_name: tag)
        @tag = Tag.find_by(tag_name: tag)
      else
        @tag = Tag.new(tag_name: tag)
        @tag.save
      end

      @search = Search.new(post_id: params[:post_id], tag_id: params[:tag_id])
      @search.post_id = @post.id
      @search.tag_id = @tag.id
      @search.save
    end
  end


  def edit
    @post = Post.find_by(id: params[:id])
    @search_tags = @post.search_tags

  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.title = params[:title]
    @post.content = params[:content]

    if params[:image]
      @post.post_image ="#{@post.id}.jpg"
      image = params[:image]
      File.binwrite("public/post_image/#{@post.post_image}", image.read)
    end

    if @post.save
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end

    @checked_tags = Tag.where(id: params[:now_tags])
    @checked_tags.each do |tag|
      @delete_tag = Search.find_by(post_id: @post.id, tag_id: tag.id)
      @delete_tag.destroy
    end

    @tag = params[:tag_name]
    @base_tags = @tag.delete("　")
    @tags = @base_tags.split(",")

    @tags.each do |tag|
      if  Tag.exists?(tag_name: tag)
        @tag = Tag.find_by(tag_name: tag)
      else
        @tag = Tag.new(tag_name: tag)
        @tag.save
      end

      @search = Search.new(post_id: params[:post_id], tag_id: params[:tag_id])
      @search.post_id = @post.id
      @search.tag_id = @tag.id
      @search.save
    end

  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy

    @searchs = Search.where(post_id: @post.id)
    @searchs.each do |search|
      search.destroy
    end

    @likes = Like.where(post_id: @post.id)
    @likes.each do |like|
      like.destroy
    end

    @sees = See.where(post_id: @post.id)
    @sees.each do |see|
      see.destroy
    end

    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end

end
