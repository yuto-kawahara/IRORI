require 'rails_helper'

RSpec.describe RecruitComment, type: :model do
  describe 'バリデーションのテスト' do
    subject { recruit_comment.valid? }

    let(:user) { create(:user) }
    let(:recruit) { create(:recruit) }
    let!(:recruit) { build(:recruit, user_id: user.id) }
    let!(:recruit_comment) { build(:recruit_comment, user_id: user.id, recruit_id: recruit.id) }

    context 'commentカラム' do
      it '空欄でないこと' do
        recruit_comment.comment = ''
        is_expected.to eq false
      end
      it '500文字以下であること: 500文字は〇' do
        recruit_comment.comment = Faker::Lorem.characters(number: 500)
        is_expected.to eq true
      end
      it '500文字以下であること: 501文字は×' do
        recruit_comment.comment = Faker::Lorem.characters(number: 501)
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(RecruitComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Recruitモデルとの関係' do
      it 'N:1となっている' do
        expect(RecruitComment.reflect_on_association(:recruit).macro).to eq :belongs_to
      end
    end
    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(RecruitComment.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end
