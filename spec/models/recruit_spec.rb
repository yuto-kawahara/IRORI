require 'rails_helper'

RSpec.describe Recruit, type: :model do
  describe 'バリデーションのテスト' do
    subject { recruit.valid? }

    let(:user) { create(:user) }
    let!(:recruit) { build(:recruit, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        recruit.title = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 200文字は〇' do
        recruit.title = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '201文字以下であること: 201文字は×' do
        recruit.title = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
    context 'start_timeカラム' do
      it '空欄でないこと' do
        recruit.start_time = ''
        is_expected.to eq false
      end
    end
    context 'capacityカラム' do
      it '空欄でないこと' do
        recruit.capacity = ''
        is_expected.to eq false
      end
    end
    context 'time_requiredカラム' do
      it '空欄でないこと' do
        recruit.time_required = ''
        is_expected.to eq false
      end
    end

    context 'explanationカラム' do
      it '1000文字以下であること: 1000文字は〇' do
        recruit.explanation = Faker::Lorem.characters(number: 1000)
        is_expected.to eq true
      end
      it '1000文字以下であること: 1001文字は×' do
        recruit.explanation = Faker::Lorem.characters(number: 1001)
        is_expected.to eq false
      end
    end

    context 'discord_server_linkカラム' do
      it '空欄でないこと' do
        recruit.discord_server_link = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 200文字は〇' do
        recruit.discord_server_link = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること: 201文字は×' do
        recruit.discord_server_link = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end

  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Recruit.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'RecruitPlayFormモデルとの関係' do
      it '1:Nとなっている' do
        expect(Recruit.reflect_on_association(:recruit_play_forms).macro).to eq :has_many
      end
    end
    context 'RecruitEntryConditionモデルとの関係' do
      it '1:Nとなっている' do
        expect(Recruit.reflect_on_association(:recruit_entry_conditions).macro).to eq :has_many
      end
    end
    context 'Reserveモデルとの関係' do
      it '1:Nとなっている' do
        expect(Recruit.reflect_on_association(:reserves).macro).to eq :has_many
      end
    end
    context 'RecruitCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Recruit.reflect_on_association(:recruit_comments).macro).to eq :has_many
      end
    end
    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Recruit.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end
