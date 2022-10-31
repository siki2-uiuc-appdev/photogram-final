class UsersController < ApplicationController

  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :desc })
    render({ :template => "users/index.html.erb"})
  end

  def show
    the_name = params.fetch("username")

    matching_users = User.where( {:username => the_name })

    @the_user = matching_users.first

    render({ :template => "users/show.html.erb" })
  end

end
