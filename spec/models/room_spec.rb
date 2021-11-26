require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Messageモデルとの関係' do
      it '1:Nとなっている' do
        expect(Room.reflect_on_association(:messages).macro).to eq :has_many
      end
    end
    context 'UserRoomモデルとの関係' do
      it '1:Nとなっている' do
        expect(Room.reflect_on_association(:user_rooms).macro).to eq :has_many
      end
    end
  end
end
