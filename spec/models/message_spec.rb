require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'バリデーションのテスト' do
    subject { message.valid? }

    let(:user) { create(:user) }
    let(:room) { create(:room) }
    let!(:message) { build(:message, user_id: user.id, room_id: room.id) }

    context 'contentカラム' do
      it '空欄でないこと' do
        message.content = ''
        is_expected.to eq false
      end
      it '500文字以下であること: 500文字は〇' do
        message.content = Faker::Lorem.characters(number: 500)
        is_expected.to eq true
      end
      it '500文字以下であること: 501文字は×' do
        message.content = Faker::Lorem.characters(number: 501)
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Message.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Roomモデルとの関係' do
      it 'N:1となっている' do
        expect(Message.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Message.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end
