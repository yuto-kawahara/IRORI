require 'rails_helper'

RSpec.describe DiscordServerLink, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(DiscordServerLink.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
