class LikesController < ApplicationController
  before_action :authenticate_user
  
  def create
    #ログイン中のユーザと投稿のIDからいいねのデータを作成
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
    #保存
    @like.save
    #見ている投稿詳細ページに返す
    redirect_to("/posts/#{params[:post_id]}")
  end

  def destroy
    #ログイン中のユーザと投稿のIDからいいねのデータを取得
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
    #削除
    @like.destroy
    #見ている投稿詳細ページに返す
    redirect_to("/posts/#{params[:post_id]}")
  end

end
