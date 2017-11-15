module Features
  def login_with_github
    visit root_url
    click_link "Sign up with Github"
  end
end