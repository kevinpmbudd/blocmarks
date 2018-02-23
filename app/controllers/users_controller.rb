class UsersController < ApplicationController
  def show
    @user_bookmarks = Bookmark.where(user: current_user)
    @liked_bookmarks = Bookmark.joins(:likes).where(likes: { user_id: current_user.id } )
  end
end
