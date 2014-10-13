class CommentsController < ActionController::Base
  def show
    @comment = Comment.first
  end

  def index
    @comments = Comment.all
    @page = params[:page].to_i
  end
end
