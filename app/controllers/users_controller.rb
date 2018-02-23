class UsersController < ApplicationController
  def show
    @user_bookmarks = Bookmark.where(user: current_user)
    likes = Like.where(user: current_user)
    @liked_bookmarks = likes.map do |like| like.bookmark end
  end
end
