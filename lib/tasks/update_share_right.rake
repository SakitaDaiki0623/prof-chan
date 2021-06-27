namespace :update_share_right do
  desc '全てのユーザのslack共有の権利を更新'
  task update_share_right: :environment do
    User.find_each do |user|
      logger.debug 'update_share_right started!'
      user.share_right.question_active! if user.share_right.question_inactive?
      user.share_right.ranking_active! if user.share_right.ranking_inactive?
      user.share_right.yes_or_no_active! if user.share_right.yes_or_no_inactive?
      user.share_right.text_active! if user.share_right.text_inactive?
    end
  end
end
