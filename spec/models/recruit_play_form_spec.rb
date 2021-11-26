require 'rails_helper'

RSpec.describe RecruitPlayForm, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Recruitモデルとの関係' do
      it 'N:1となっている' do
        expect(RecruitPlayForm.reflect_on_association(:recruit).macro).to eq :belongs_to
      end
    end
    context 'PlayFormモデルとの関係' do
      it 'N:1となっている' do
        expect(RecruitPlayForm.reflect_on_association(:play_form).macro).to eq :belongs_to
      end
    end
  end
end
