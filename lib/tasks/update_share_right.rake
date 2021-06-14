namespace :update_share_right do
  desc '全てのユーザのslack共有の権利を更新'
  task update_share_right: :environment do
    User.find_each do |user|
      logger.debug 'update_share_right started!'
      user.question_not_shared_yet! if user.question_already_shared?
      user.ranking_not_shared_yet! if user.ranking_already_shared?
      user.yes_or_no_not_shared_yet! if user.yes_or_no_already_shared?
      user.text_not_shared_yet! if user.text_already_shared?
    end
  end
end
