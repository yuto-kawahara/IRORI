require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'アソシエーションのテスト' do
    context 'followingモデルとの関係' do
      it 'N:1となっている' do
        expect(Relationship.reflect_on_association(:following).macro).to eq :belongs_to
      end
    end
    context 'followedモデルとの関係' do
      it 'N:1となっている' do
        expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
      end
    end
  end
end
