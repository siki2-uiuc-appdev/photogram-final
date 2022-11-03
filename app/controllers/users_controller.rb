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



    render({ :template => "users/show.html.erb" })
  end

  

end
