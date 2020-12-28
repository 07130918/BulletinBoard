class BoardsController < ApplicationController
  # %iで要素がシンボルの配列を作る
  before_action :set_target_board, only: %i[show edit update destroy]

  def index
    @boards = params[:tag_id].present? ? Tag.find(params[:tag_id]).boards : Board.all
    @boards = @boards.page(params[:page])
  end

  def new
    @board = Board.new(flash[:board])
  end

  def create
    board = Board.new(board_params)

    #バリデーションチェック
    if board.save
      flash[:notice] = "「#{board.title}」の掲示板を作成しました"

      # views/boards/showで参照
      redirect_to board
    else
      redirect_to new_board_path,
                  flash: {
                    board: board,
                    error_messages: board.errors.full_messages,
                  }
    end
  end

  def show
    @comment = Comment.new(board_id: @board.id)
  end

  def edit; end

  def update
    #バリデーションチェック
    if @board.update(board_params)
      # /boards/:idのパスにリダイレクト
      redirect_to @board
    else
      redirect_to board_path(@board.id),
                  flash: {
                    board: @board,
                    error_messages: @board.errors.full_messages,
                  }
    end
  end

  def destroy
    @board.destroy
    redirect_to :root,
                flash: { notice: "「#{@board.title}」の掲示板が削除されました" }
  end

  private

  def board_params
    params.require(:board).permit(:name, :title, :body, tag_ids: [])
  end

  def set_target_board
    @board = Board.find(params[:id])
  end
end
