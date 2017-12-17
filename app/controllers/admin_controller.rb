class AdminController < ApplicationController
   skip_before_filter :verify_authenticity_token
  def home
    if session[:state]=="from_signin" or session[:state]=="from_viewbook" or session[:state]=="from_profile" or session[:state]=="from_removebook" or session[:state]=="from_addbook" or session[:state]=="from_updatebook" or session[:state]=="from_addcategory"
      session[:state]="from_admin_home"
    else
       redirect_to url_for(:controller => :admin, :action => :home)
     end 

  end
  def addbook
  
    if session[:state]=="from_admin_home"
      session[:state]="from_addbook"
    else
       redirect_to url_for(:controller => :home, :action => :home)
     end 
    
  end
  def addbookaction
   # if session[:state]=="from_addbook"
      @book=Book.new
      @book.name=params["name"]
      @book.author=params["author"]
      @book.category=params["category"]
      @book.picture=params["picture"]
      @book.file=params["file"]
      if @book.save
        @msg="Book added successfully"
        render 'home'
      else
        @msg="Book not added"
      end
   # else
   #    redirect_to url_for(:controller => :home, :action => :home)
   #  end 
  	
  end

  def removebook
    puts session[:state]
    if session[:state]=="from_admin_home"
      session[:state]="from_removebook"
    else
       redirect_to url_for(:controller => :home, :action => :home)
     end 
  end

  def removebookaction
    if session[:state]=="from_removebook"
      session[:state]="from_admin_home"
      @bookname=params["name"]
      @book=Book.find_by_name(@bookname)
      if @book    
          if @book.delete
            @msg="Book deleted successfully"
          else
            @msg="Book not deleted"
          end
      else
        @msg="Book not founded"
      end
    else
       redirect_to url_for(:controller => :home, :action => :home)
     end 
  	
  end
  def updatebook
    if session[:state]=="from_admin_home"
      session[:state]="from_updatebook"
    else
       redirect_to url_for(:controller => :home, :action => :home)
     end 
  end
  def updatebookaction
    if session[:state]=="from_updatebook"
      
      @bookname=params["name"]
    @book=Book.find_by_name(@bookname)
    if @book
      puts params["author"]
      author=params["author"]
      category=params["category"]
      picture=params["picture"]
      file=params["file"]
      unless author.to_s.empty?
        @book.author=author
      end
      unless category.to_s.empty?
         @book.category=category
       end
      unless picture.to_s.empty?
         @book.picture=picture
      end
      unless file.to_s.empty?
        @book.file=file
      end
      if @book.save
        @msg="updated successfully"
      else
        @msg="Book not updated"
      end
    else
      @msg="Book not found"
    end
  end
    else
       redirect_to url_for(:controller => :home, :action => :home)
     end 
   def addcategory
    if session[:state]=="from_admin_home"
      session[:state]="from_addcategory"
    else
      redirect_to url_for(:controller => :home, :action => :home)
    end

   end 
   def addcategoryaction
    name=params["name"]
    category=Category.new
    category.name=name
    if category.save
      @msg="category Added"
      render 'home'
    else
      @msg="category not added"
    end
   end 
  def viewbook
    if session[:state]=="from_admin_home" or session[:state]=="from_viewbook"
      @books=Book.paginate(:page => params[:page], :per_page => 10)
      session[:state]="from_viewbook"
    else
      redirect_to url_for(:controller => :home, :action => :home)
    end
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

end
