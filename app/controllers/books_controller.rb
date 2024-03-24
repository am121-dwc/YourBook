class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
    @books = Book.all
    @tag_list = Tag.all
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    @tag_list = @book.tags.pluck(:name).join(',')
  end

  def update
    @book = Book.find(params[:id])
    tag_list = params[:book][:name].split(',')
    if @book.update(book_params)
      @book.save_tags(tag_list)
      redirect_to book_path(@book), notice: "Book was updated."
    else
      flash.now[:alert] = "Book was not updated."
      reuest.referer
    end
  end

  def create
    # 本の作成時にタグの情報を付与
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # 入力された値を.で区切って配列に格納
    tag_list = params[:book][:name].split(',')
    if @book.save
      @book.save_tags(tag_list)
      redirect_to book_path(@book), notice: "本の作成に成功しました"
    else
      flash.now[:alert] = "本の作成に失敗しました。タイトルと紹介文を空にする事はできません。また、紹介文は200文字までしか登録できません。"
      render 'new'
    end
  end
  def show
   @book = Book.find(params[:id])
   @book_comment = BookComment.new
   @tag_list = @book.tags.pluck(:name).join(',')
   @book_tags = @book.tags
  end
  def search_tag
    # 検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
    # 検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    # 検索されたタグに紐づく投稿を表示
    @book = @tag.books
  end
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to request.referer
  end

  private
  def book_params
    params.require(:book).permit(:title, :introduction, :profile_image)
  end
end
