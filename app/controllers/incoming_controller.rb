class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @user = User.find_by_email( params[:sender] )
    @topic = Topic.find_by_title( params[:subject] )
    @url = params["body-plain"]

    # mailgun only allows sending email to authorized recipients while mailgun
    # is in developer "sandbox" mode. Since new users are sent an email to confirm
    # account before they can activate account this operation will fail on the production
    # server. To test, first create a blocmarks user and then email bookmarks from
    # the associated blocmark users' email.
    if @user.nil?
      @user = User.create!(name: params[:sender],
                             email: params[:sender],
                             password: 'helloworld',
                             password_confirmation: 'helloworld')
    end

    if @topic.nil?
      @topic = Topic.create!(title: params[:subject], user_id: @user.id)
    end

    @bookmark = @topic.bookmarks.build(url: @url)
    @bookmark.user = @user 

    if @bookmark.save
      head 200
    else
      puts "error saving bookmark: #{bookmark}"
    end
  end
end
