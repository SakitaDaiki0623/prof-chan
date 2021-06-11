namespace :update_share_right do
  desc "全てのユーザのslack共有の権利を更新"
  task update_share_right: :environment do
    User.find_each do |user|
      logger.debug "update_share_right started!"
      user.not_shared_yet! if user.already_shared?
    end
  end
end
