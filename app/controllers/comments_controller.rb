class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      flash[:notice] = 'コメントを投稿しました'
      # commentのidに紐づくboardを自動取得してくれる
      redirect_to comment.board
    else
      flash[:comment] = comment
      flash[:error_messages] = comment.errors.full_messages
      # redirect_backで1つ前の画面に戻る
      redirect_back fallback_location: comment.board
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to comment.board, flash: { notice: 'コメントが削除されました'}
  end

  private

  def comment_params
    params.require(:comment).permit(:board_id, :name, :comment)
  end
end
