class UsersController < ApplicationController

  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :asc })
    render({ :template => "users/index.html.erb"})
  end

  def show
    the_name = params.fetch("username")

    matching_users = User.where( {:username => the_name })

    @the_user = matching_users.first
    
    @content = @the_user.own_photos

    if params.key?("route")
      @route = params.fetch("route")
      case @route
      when "feed"
        @content = @the_user.feed
      when "liked_photos"
        @content = @the_user.liked_photos
      when "discover"
        @content = @the_user.discover
      when "profile"
        @content = @the_user.own_photos
      end
      
    end

    if @current_user != nil 
      if @the_user.followers.where( :id => @current_user.id).first || !@the_user.private
        render({ :template => "users/show.html.erb" })
      elsif @current_user.id == @the_user.id
        render({ :template => "users/show.html.erb" })
      else 
        redirect_to("/users", { :alert => "You're not authorized for that."})
      end
    else
      redirect_to("/user_sign_in", { :alert => "You have to sign in first."})
    end

  end

  

end
