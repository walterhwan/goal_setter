require 'rails_helper'

RSpec.describe User, type: :model do
  describe "user model" do
    before(:each) do
      user_params = {username: 'Walter', password: 'password'}
      user = User.create!(user_params)
    end

    it "validates everything " do
      it { should validate_presence_of(:username) }
      it { should validate_presence_of(:password_digest) }
      it { should validate_presence_of(:session_token) }
      it { should validate_length_of(:password).is_at_least(6) }
    end

    # it "has correct associations" do
    #   it { should have_many(:basketball_players)}
    # end

    it 'finds correct user with credentials' do
      expect(user).to eq(User.find_by_credentials(user_params))
    end

    it 'returns nil with invalid credentials' do
      expect(User.find_by_credentials(username: 'Walter', password: '')).to be_nil
    end

    it 'resets session token' do
      session_token = user.session_token
      user.reset_session_token

      expect(session_token).to_not be user.session_token
    end

    it 'checks if password is correct' do
      expect(user.is_password?(user_params[:password])).to be_true
    end

    it 'returns false if password is not correct' do
      expect(user.is_password?('asdf')).to be_false
    end
  end

end
















#end
