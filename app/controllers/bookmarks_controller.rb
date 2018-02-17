require 'metainspector'

class BookmarksController < ApplicationController
  before_action :bookmarks, only: [:create, :destroy]
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]
  before_action :set_topic, only: [:new, :create, :edit, :destroy]
  before_action :authenticate_user!, except: [:show]

  def show
    @page = MetaInspector.new(@bookmark.url)
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = @topic.bookmarks.create( bookmark_params )
  end

  def update
    @bookmark.update( bookmark_params )
    redirect_to [@bookmark.topic, @bookmark]
  end

  def destroy
    @topics = Topic.all.order('updated_at DESC').includes(:bookmarks)

    if @bookmark.destroy
      redirect_to @bookmark.topic
    end
  end

  private

  def bookmarks
    @bookmarks = Bookmark.where(topic_id: params[:topic_id])
  end

  def set_bookmark
    @bookmark = Bookmark.find_by_id( params[:id] )
  end

  def set_topic
    @topic = Topic.find_by_id( params[:topic_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end
end
