class PostsController < ApplicationController
  before_action :session_required, only: [:create]
  before_action :set_board, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    # @post = Post.new(post_params)
    # @post.board = @board
    # @post.user = current_user

    # @post = @board.posts.new(post_params)
    # @post.user = current_user

    @post = current_user.posts.new(post_params)
    @post.board = @board

    if @post.save
      redirect_to @board, notice: '新增文章成功'
    else
      render :new
    end
  end

  private
  def set_board
    @board = Board.find(params[:board_id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end