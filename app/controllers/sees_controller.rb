class SeesController < ApplicationController

  def create
    @see = See.new(user_id: @current_user.id, post_id: params[:post_id])
    @see.save
    redirect_to("/posts/#{params[:post_id]}")
  end

  def destroy
    @see = See.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @see.destroy
    redirect_to("/posts/#{params[:post_id]}")
  end
end
