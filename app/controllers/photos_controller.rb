class PhotosController < ApplicationController
  def index
    matching_photos = Photo.all
    public_profiles = User.where({ :private => false })
    public_photos_array = Array.new

    # @list_of_photos = matching_photos.order({ :created_at => :desc })
    public_profiles.each do |profile|
      profile.own_photos.each do | photo |
        public_photos_array.push(photo)
      end
    end

    @list_of_photos = public_photos_array
    

    render({ :template => "photos/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_photos = Photo.where({ :id => the_id })

    @the_photo = matching_photos.at(0)
    if @current_user != nil
      render({ :template => "photos/show.html.erb" })
    else
      redirect_to("/user_sign_in", { :alert => "You have to sign in first."})
    end
  end

  def create
    the_photo = Photo.new
    the_photo.image = params.fetch("query_image")
    the_photo.caption = params.fetch("query_caption")
    the_photo.comments_count = params.fetch("query_comments_count")
    the_photo.likes_count = params.fetch("query_likes_count")
    the_photo.owner_id = @current_user.id

    if the_photo.valid?
      the_photo.save
      redirect_to("/photos", { :notice => "Photo created successfully." })
    else
      redirect_to("/photos", { :alert => the_photo.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_photo = Photo.where({ :id => the_id }).at(0)

    # the_photo.image = params.fetch("query_image")
    the_photo.image = params.fetch(:image)
    the_photo.caption = params.fetch("query_caption")
    the_photo.comments_count = params.fetch("query_comments_count")
    the_photo.likes_count = params.fetch("query_likes_count")
    the_photo.owner_id = @current_user.id

    if the_photo.valid?
      the_photo.save
      redirect_to("/photos/#{the_photo.id}", { :notice => "Photo updated successfully."} )
    else
      redirect_to("/photos/#{the_photo.id}", { :alert => the_photo.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_photo = Photo.where({ :id => the_id }).at(0)

    the_photo.destroy

    redirect_to("/photos", { :notice => "Photo deleted successfully."} )
  end
end
