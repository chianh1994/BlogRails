class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    user = User.find params[:user_id]
    if (current_user?(user) || current_user.following?(user))
      entry = Entry.find(params[:entry_id])
      @comment = entry.comments.build(comment_params)
      @comment.user = user
      if @comment.save
        respond_to do |format|
          format.html{redirect_to request.referrer}
          format.js
        end
      else
        flash[:warning] = "Loi roi"
        redirect_to request.referrer
      end
    else
      flash[:warning] = "You have to follow this user"
      redirect_to request.referrer
    end
  end

  def destroy; end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
