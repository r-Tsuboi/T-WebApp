class SeesController < ApplicationController
  before_action :authenticate_user

  def create
    #ログイン中のユーザと投稿のIDから新しいわかるのデータを作る
    @see = See.new(user_id: @current_user.id, post_id: params[:post_id])
    #保存する
    @see.save
    #見ている投稿詳細ページにページを返す
    redirect_to("/posts/#{params[:post_id]}")
  end

  def destroy
    #ログイン中のユーザと投稿のIDからわかるのデータを見つけ出す
    @see = See.find_by(user_id: @current_user.id, post_id: params[:post_id])
    #削除する
    @see.destroy
    #見ている投稿詳細ページに返す
    redirect_to("/posts/#{params[:post_id]}")
  end
end
