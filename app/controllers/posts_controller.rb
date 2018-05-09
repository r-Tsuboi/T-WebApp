class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
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
      @post.post_image = "#{@post.id}.jpg"
      image = params[:image]
      File.binwrite("public/post_image/#{@post.post_image}", image.read)
    else
      @post.post_image = "default_post.jpg"
    end

    if @post.save
      redirect_to("/posts/index")
    else
      render("posts/new")
    end


    if  Tag.exists?(tag_name: params[:tag_name])
      @tag = Tag.find_by(tag_name: params[:tag_name])
    else
      @tag = Tag.new(tag_name: params[:tag_name])
      @tag.save
    end
    @search = Search.new(post_id: params[:post_id], tag_id: params[:tag_id])
    @search.post_id = @post.id
    @search.tag_id = @tag.id
    @search.save
  end


  def edit
    @post = Post.find_by(id: params[:id])
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
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "削除しました"
    redirect_to("/posts/index")
  end


end
