class BookCommentsController < ApplicationController

  def create
    #ネストしたURLを作成することでparams[:book_id]でBookのidが取得できるようになる
    book = Book.find(params[:book_id])
    #ログインしているユーザに空を渡す
    @comment = current_user.book_comments.new(book_comment_params)
    #どの投稿にコメントしているか
    @comment.book_id = book.id
    @comment.save
  end

  def destroy
    #コメントのidとBookのidを取得し削除
    # find_byメソッド→モデルの主キー以外の条件でも、レコードを取得することができる
    #BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    @comment = BookComment.find(params[:id])
    @comment.destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
