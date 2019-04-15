class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])

      #本日投稿しているかどうか
      @feed_today = current_user.feed_0d
      
      #本日から6日前までのスコア
      if current_user.feed_0d.count==0
          @feed_score_today = 0
      else
          @feed_score_today = current_user.feed_0d.last.score
      end

      if current_user.feed_1d.count == 0
          @feed_score_yesterday = 0
      else
          @feed_score_yesterday = current_user.feed_1d.last.score
      end

      if current_user.feed_2d.count == 0
          @feed_score_2days_ago = 0
      else
          @feed_score_2days_ago = current_user.feed_2d.last.score
      end     

      if current_user.feed_3d.count == 0
          @feed_score_3days_ago = 0
      else
          @feed_score_3days_ago = current_user.feed_3d.last.score
      end  

      if current_user.feed_4d.count == 0
          @feed_score_4days_ago = 0
      else
          @feed_score_4days_ago = current_user.feed_4d.last.score
      end  

      if current_user.feed_5d.count == 0
          @feed_score_5days_ago = 0
      else
          @feed_score_5days_ago = current_user.feed_5d.last.score
      end

      if current_user.feed_6d.count == 0
          @feed_score_6days_ago = 0
      else
          @feed_score_6days_ago = current_user.feed_6d.last.score
      end

      #スコアを配列に入れ、JSに移動
      @feed_scores_1week =[@feed_score_6days_ago,@feed_score_5days_ago,@feed_score_4days_ago,@feed_score_3days_ago,@feed_score_2days_ago,@feed_score_yesterday,@feed_score_today]
      @feed_scores_1week_json = @feed_scores_1week.to_json.html_safe
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end