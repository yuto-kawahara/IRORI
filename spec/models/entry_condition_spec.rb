require 'rails_helper'

RSpec.describe EntryCondition, type: :model do
  describe 'アソシエーションのテスト' do
    context 'RecruitEntryConditionモデルとの関係' do
      it '1:Nとなっている' do
        expect(EntryCondition.reflect_on_association(:recruit_entry_conditions).macro).to eq :has_many
      end
    end
  end
end
