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
    @bookmark = @topic.bookmarks.build( bookmark_params )
    @bookmark.user = current_user

    respond_to do |format|
      if @bookmark.save
        format.js
      else
        format.js { flash.now[:alert] = "There was an error creating the bookmark." }
      end
    end
  end

  def update
    authorize @bookmark

    @bookmark.update( bookmark_params )
    redirect_to [@bookmark.topic, @bookmark]
  end

  def destroy
    authorize @bookmark

    @topics = Topic.all.order('updated_at DESC').includes(:bookmarks)

    respond_to do |format|
      if @bookmark.destroy
        format.html { redirect_to @topic }
        format.js
      else
        format.html { flash.now[:alert] = "There was an error deleting the bookmark." }
      end
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
