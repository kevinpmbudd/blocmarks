class LikesController < ApplicationController
  before_action :set_bookmark, only: [:create, :destroy]

  def index
    @likes = Like.all
  end

  def create
    like = current_user.likes.build( bookmark: @bookmark )

    authorize like

    if like.save
      flash[:notice] = "Bookmark liked."
    else
      flash[:alert] = "There was an error liking the bookmark. Please try again."
    end
    redirect_to [@bookmark.topic, @bookmark]
  end

  def destroy
    like = current_user.likes.find_by_id( params[:id] )

    authorize like

    if like.destroy
      flash[:notice] = "Bookmark unliked"
    else
      flash[:alert] = "There was an error unliking the bookmark. Please try again."
    end
    redirect_to [@bookmark.topic, @bookmark]
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find_by_id( params[:bookmark_id] )
  end

end
