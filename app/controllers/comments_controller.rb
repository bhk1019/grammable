class CommentsController < ApplicationController
before_action :authenticate_user!, only: [:create]

  def create
    @gram = Gram.find_by_id(params[:gram_id])
    return render_not_found if @gram.blank? 
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @gram.comments.create(comment_params)
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:message).merge(user: current_user)
  end


end
