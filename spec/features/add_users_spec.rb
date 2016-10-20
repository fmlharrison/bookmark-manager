
feature "add user" do

  scenario 'adding a user' do
    visit '/'
    click_button 'Sign up'
    fill_in :email, with: 'felixthecat@felix.com'
    fill_in :username, with: 'Felix123'
    fill_in :password, with: 'felixthecatmiaumiau'
    click_button 'Create user'

    expect{click_button 'Create user'}.to change{User.count}.by(1)
  end

  scenario 'new user sees confirmation of sign up' do
    visit '/'
    click_button 'Sign up'
    fill_in :email, with: 'felixthecat@felix.com'
    fill_in :username, with: 'Felix123'
    fill_in :password, with: 'felixthecatmiaumiau'
    click_button 'Create user'

    expect(page).to have_content "You are signed in as felixthecat@felix.com"
  end

end
