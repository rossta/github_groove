require "spec_helper"

describe UserRepository do
  before do
    UserRepository.clear
  end

  describe ".from_omniauth" do
    it "creates new user" do
      omniauth = OmniAuth.config.mock_auth[:github].dup

      user = UserRepository.from_omniauth(omniauth)

      user.id.wont_be_nil
      user.name.must_equal "Ross Kaffenberger"
      user.nickname.must_equal "rossta"
      user.github_id.must_equal 11_673
      user.email.must_equal "ross@example.com"
      user.github_access_token.must_equal "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    end

    it "updates existing user" do
      omniauth = OmniAuth.config.mock_auth[:github].dup
      created_user = UserRepository.from_omniauth(omniauth)

      omniauth.info.name = "Ray Ray"

      updated_user = UserRepository.from_omniauth(omniauth)
      created_user.id.must_equal updated_user.id
      updated_user.name.must_equal "Ray Ray"
    end
  end
end
