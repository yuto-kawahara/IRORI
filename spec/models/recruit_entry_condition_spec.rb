require 'rails_helper'

RSpec.describe RecruitEntryCondition, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Recruitモデルとの関係' do
      it 'N:1となっている' do
        expect(RecruitEntryCondition.reflect_on_association(:recruit).macro).to eq :belongs_to
      end
    end
    context 'EntryConditionモデルとの関係' do
      it 'N:1となっている' do
        expect(RecruitEntryCondition.reflect_on_association(:entry_condition).macro).to eq :belongs_to
      end
    end
  end
end
