module CreateProfileSupport
  def create_profile
    expect(current_path).to eq(new_profile_path), 'パスがnew_profile_pathではありません'
    profile = create(:profile)
    fill_in 'profile_height',	with: profile.height
    select profile.blood_type, from: 'profile_blood_type'
    select profile.prefecture.name, from: 'profile_prefecture_id'
    select '男性', from: 'profile_gender'
    fill_in 'profile_birthday',	with: profile.birthday
    fill_in 'profile_day_of_joinning',	with: profile.day_of_joinning
    expect{ click_on '入力完了！' }.to change(Profile, :count).by(1), 'プロフィール数が1つ増えていません'
  end
end