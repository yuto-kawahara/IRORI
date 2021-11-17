require 'rails_helper'

RSpec.describe Reserve, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Reserve.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Recruitモデルとの関係' do
      it 'N:1となっている' do
        expect(Reserve.reflect_on_association(:recruit).macro).to eq :belongs_to
      end
    end
  end
end
