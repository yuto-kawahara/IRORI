require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  describe 'バリデーションのテスト' do
    subject { evaluation.valid? }

    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let!(:evaluation) { build(:evaluation, reviewer_id: user.id, reviewee_id: other_user.id) }

    context 'starsカラム' do
      it '空欄でないこと' do
        evaluation.stars = ''
        is_expected.to eq false
      end
    end

    context 'commentカラム' do
      it '空欄でないこと' do
        evaluation.comment = ''
        is_expected.to eq false
      end
      it '500文字以下であること: 500文字は〇' do
        evaluation.comment = Faker::Lorem.characters(number: 500)
        is_expected.to eq true
      end
      it '500文字以下であること: 501文字は×' do
        evaluation.comment = Faker::Lorem.characters(number: 501)
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Reviewerモデルとの関係' do
      it 'N:1となっている' do
        expect(Evaluation.reflect_on_association(:reviewer).macro).to eq :belongs_to
      end
    end
    context 'Revieweeモデルとの関係' do
      it 'N:1となっている' do
        expect(Evaluation.reflect_on_association(:reviewee).macro).to eq :belongs_to
      end
    end
    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Evaluation.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end
