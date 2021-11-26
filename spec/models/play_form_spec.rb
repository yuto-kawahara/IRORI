require 'rails_helper'

RSpec.describe PlayForm, type: :model do
  describe 'アソシエーションのテスト' do
    context 'RecruitPlayFormモデルとの関係' do
      it '1:Nとなっている' do
        expect(PlayForm.reflect_on_association(:recruit_play_forms).macro).to eq :has_many
      end
    end
  end
end
