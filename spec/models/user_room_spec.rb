require 'rails_helper'

RSpec.describe UserRoom, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(UserRoom.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Recruitモデルとの関係' do
      it 'N:1となっている' do
        expect(UserRoom.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
  end
end
