class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id:params[:id])
    @user = User.find_by(id: @post.user_id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(title: params[:title], content: params[:content],
                      post_image: params[:post_image], user_id:@current_user.id)
    @post.title = params[:title]
    @post.content = params[:content]

      @post.post_image = "#{@post.id}.jpg"
      image = params[:image]
      File.binwrite("public/post_image/#{@post.post_image}", image.read)

    if @post.save
      redirect_to("/posts/index")
    else
      render("posts/new")
    end

  end

end
