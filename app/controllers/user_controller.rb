class UserController < ApplicationController
   skip_before_filter :verify_authenticity_token

   def searchaction
    #@book=@books1
    @list=Category.all
     puts "User HOME"
          @id=session[:userid]
          user=UserDetail.find(@id)
          @username=user.name
          @book=Book1.all
  end

  def searchaction1
    #@book=@books1
    @list=Category.all
     puts "User HOME"
          @id=session[:userid]
          user=UserDetail.find(@id)
          @username=user.name
  end

  def home
    @list=Category.all
     puts "User HOME"
          @id=session[:userid]
          user=UserDetail.find(@id)
          @username=user.name
          #@list=Book.uniq.pluck(:category)
    if session[:state]=="from_search"
       @book=Book1.paginate(:page => params[:page], :per_page => 6)
        #@book=[]
        #for i in @books
          #@book.push(Book.paginate(:page => params[:page], :per_page => 6).find_by_name(i))
           #@book = Book.paginate(:page => params[:page], :per_page => 6)
           #@book=Book.find(:all, :name => "c").paginate(:page => params[:page], :per_page => 6)

           #@book=Book.where(:conditions => ["name in ?",['c']]).paginate(:page => params[:page], :per_page => 6)

            #@book = Book.where("name in ?",@books1).paginate(:page => params[:page], :per_page => 6)




        #end
    elsif session[:state]=="from_signin" or session[:state]=="from_home" or session[:state]=="from_book" or session[:state]=="from_profile"
        session[:state]="from_home" or session[:state]=="from_search"
        
          
          if params["category"].to_s.empty?
            #@book=Book.all
            @cat="All Books"
            @book = Book.paginate(:page => params[:page], :per_page => 6)
          else
            @cat="Books under category "+params["category"]
            #@book = Book.all(:conditions => {'category' => params["category"]})
            @book = Book.where("category = ?",params["category"]).paginate(:page => params[:page], :per_page => 6)
          end
          for book1 in @book 
            puts book1
          end  	
    else
      redirect_to url_for(:controller => :home, :action => :home)
    end

  end

  def catogory
  end

  def book
    puts session[:state]
    #if session[:state]=="from_home" or session[:state]=="from_" 
    	@pic=params["picture"]
    	@name=params["name"]
    	@file=params["file"]
    	#@list=Book.uniq.pluck(:category)
      @list=Category.all
      session[:state]="from_book"
    #else
     #  redirect_to url_for(:controller => :home, :action => :home)
    #end
  end

  def profile
    session[:state]="from_profile"
    if session[:userid]
      id=session[:userid]
      user=UserDetail.find(id)
      @name=user.name
      @email=user.email
      @mobile=user.mobile
      @username=user.username
    else
       redirect_to url_for(:controller => :home, :action => :home)
    end
  end
  def search
    search=params["search"]
    session[:state]="from_search"
    names=Book.uniq.pluck(:name)
    categories=Book.uniq.pluck(:category)
    @books1=[]
    for i in names 
      if i.include? search
        @books1.push(i)
      end
    end
    Book1.destroy_all
    for i in @books1
      book2=Book1.new
      book1=Book.find_by_name(i)
      book2.name=book1.name
      book2.category=book1.category
      book2.author=book1.author
      book2.picture=book1.picture
      book2.file=book1.file
      book2.save
    end
    redirect_to url_for(:controller => :user, :action => :home)
  end
end