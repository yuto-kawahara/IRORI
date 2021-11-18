require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let(:user) { create(:user) }

    context 'nicknameカラム' do
      it '空欄でないこと' do
        user.nickname = ''
        is_expected.to eq false
      end
      it '50文字以下であること: 50文字は〇' do
         user.nickname = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end
      it '50文字以下であること: 51文字は×' do
        user.nickname = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end
    context 'introductionカラム' do
      it '300文字以下であること: 300文字は〇' do
        user.introduction = Faker::Lorem.characters(number: 300)
        is_expected.to eq true
      end
      it '300文字以下であること: 301文字は×' do
        user.introduction = Faker::Lorem.characters(number: 301)
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Recruitモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:recruits).macro).to eq :has_many
      end
    end
    context 'RecruitCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:recruit_comments).macro).to eq :has_many
      end
    end
    context 'Reserveモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:reserves).macro).to eq :has_many
      end
    end
    context 'Messageモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:messages).macro).to eq :has_many
      end
    end
    context 'UserRoomモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:user_rooms).macro).to eq :has_many
      end
    end
    context 'DiscordServerLinkモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:discord_server_links).macro).to eq :has_many
      end
    end
    context 'Contactモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:contacts).macro).to eq :has_many
      end
    end
    context 'followingモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:following).macro).to eq :has_many
      end
    end
    context 'followedモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:followed).macro).to eq :has_many
      end
    end
    context 'active_notificationsモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
    end
    context 'passive_notificationsモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
    end
    context 'reviewerモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:reviewer).macro).to eq :has_many
      end
    end
    context 'revieweeモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:reviewee).macro).to eq :has_many
      end
    end
  end
end
