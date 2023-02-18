class BooksController < ApplicationController
# 1.indexページにリンクをはる show,edit,destroy. ()内がbook.idではなく、list.idで良いのはどうして？
# destroy機能を追加する　どうしてdestroy_book_pathではなくbook_pathなのか
# バリデーションをつける
  def create
    # book = Book.new(list_params)
    # book.save
    #   flash[:successfully] = "Book was successfully created."
    #   redirect_to book_path(book.id)
    
     # ↓↓↓バリデーションの際のNomethoderror undefined method `each' for nil:NilClassを防ぐため
       @books = Book.all 
    # ここから下はそのまま貼りつけただけ
       @book = Book.new(list_params)
    if @book.save
      flash[:successfully] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def index
     @book = Book.new
     @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    # book = Book.find(params[:id])
    # book.update(list_params)
    # flash[:notice] = "Book was successfully updated."
    # redirect_to book_path(book.id)  
    # ↓↓↓バリデーションの際にbookを@bookにした
    @book = Book.find(params[:id])
    @book.update(list_params)
    if @book.save  
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト  
  end

  private
  # ストロングパラメータ
  def list_params
    params.require(:book).permit(:title, :body)
  end
end
