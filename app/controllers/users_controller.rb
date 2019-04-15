class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])

    #本日から6日前までのスコア
    if @user.feed_0d.count==0
        @user_feed_score_today = 0
    else
        @user_feed_score_today = @user.feed_0d.last.score
    end

    if @user.feed_1d.count==0
        @user_feed_score_yesterday = 0
    else
        @user_feed_score_yesterday = @user.feed_1d.last.score
    end

    if @user.feed_2d.count == 0
        @user_feed_score_2days_ago = 0
    else
        @user_feed_score_2days_ago = @user.feed_2d.last.score
    end     

    if @user.feed_3d.count == 0
        @user_feed_score_3days_ago = 0
    else
        @user_feed_score_3days_ago = @user.feed_3d.last.score
    end   

    if @user.feed_4d.count == 0
        @user_feed_score_4days_ago = 0
    else
        @user_feed_score_4days_ago = @user.feed_4d.last.score
    end  

    if @user.feed_5d.count == 0
        @user_feed_score_5days_ago = 0
    else
        @user_feed_score_5days_ago = @user.feed_5d.last.score
    end  

    if @user.feed_6d.count == 0
        @user_feed_score_6days_ago = 0
    else
        @user_feed_score_6days_ago = @user.feed_6d.last.score
    end  

    #スコアを配列に入れ、JSに移動
    @user_feed_scores_1week =[@user_feed_score_6days_ago,@user_feed_score_5days_ago,@user_feed_score_4days_ago,@user_feed_score_3days_ago,@user_feed_score_2days_ago,@user_feed_score_yesterday,@user_feed_score_today]
    @user_feed_scores_1week_json = @user_feed_scores_1week.to_json.html_safe

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # beforeアクション

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
