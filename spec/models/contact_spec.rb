# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Contactモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { contact.valid? }

    let(:user) { create(:user) }
    let!(:contact) { build(:contact, user_id: user.id) }

    context 'subjectカラム' do
      it '空欄でないこと' do
        contact.subject = ''
        is_expected.to eq false
      end
      it '100文字以下であること: 100文字は〇' do
        contact.subject = Faker::Lorem.characters(number: 100)
        is_expected.to eq true
      end
      it '100文字以下であること: 101文字は×' do
        contact.subject = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end

    context 'messageカラム' do
      it '空欄でないこと' do
        contact.message = ''
        is_expected.to eq false
      end
      it '1000文字以下であること: 1001文字は×' do
        contact.message = Faker::Lorem.characters(number: 1001)
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Contact.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
