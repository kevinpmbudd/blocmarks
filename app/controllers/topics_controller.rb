class TopicsController < ApplicationController
  before_action :topics, only: [:index, :create, :destroy]
  before_action :set_topic, only: [:show, :destroy]
  before_action :authenticate_user!

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.create( topic_params )
  end

  def destroy
    @topic.destroy
  end

  private

  def topics
    @topics = Topic.all.order('updated_at DESC').includes(bookmarks: [ :likes ] )
  end

  def set_topic
    @topic = Topic.friendly.find( params[:id] )
  end

  def topic_params
    params.require(:topic).permit(:title)
  end
end
