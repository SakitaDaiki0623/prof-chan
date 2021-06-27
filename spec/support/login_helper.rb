module LoginHelper
  def sign_up
    visit root_path
    find('#new-registration-button').click
    fill_in 'user_name',	with: 'サンプルネーム'
    fill_in 'user_email',	with: 'sample@example.com'
    fill_in 'user_password',	with: 'password'
    fill_in 'user_password_confirmation',	with: 'password'
    attach_file "user_image", "spec/fixtures/images/prof_normal.png"
    check "user_agreement"
    find('#complete-registration-button').click
  end

  def login
    user = create(:user)
    visit root_path
    find('#to-login-button').click
    fill_in 'user_email',	with: user.email
    fill_in 'user_password',	with: user.password
    find('#login-button').click
    expect(current_path).to eq(top_path)
  end
end