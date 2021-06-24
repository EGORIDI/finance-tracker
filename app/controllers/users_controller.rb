class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    @tracked_stocks = @user.stocks
  end

  def my_friends
    @user_friends = current_user.friends
  end

  def my_followers
    @user = current_user
    @friendships = Friendship.where(friend_id: @user)
    @followers = []
    @friendships.each do |friendship|
      @followers << User.find(friendship.user_id)
    end
  end

  def needy
    @needy = []
    User.all.each { |u| @needy << {user_id: u.id , following: u.friends.count} }
    @needy.sort_by! { |n| -n[:following]}
  end

  def popular
    @popular = []
    User.all.each do |u| 
      @popular << {user_id: u.id , followed:Friendship.where(friend_id: u.id).count  }
    end
    @popular.sort_by! { |popular| -popular[:followed]}
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: 'users/friend_result'}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Didn't find user."
          format.js { render partial: 'users/friend_result'}
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend name or email to search."
        format.js { render partial: 'users/friend_result'}
      end
    end
  end
end
