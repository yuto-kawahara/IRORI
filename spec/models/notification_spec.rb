require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Visitorモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:visitor).macro).to eq :belongs_to
      end
    end
    context 'Visitedモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:visited).macro).to eq :belongs_to
      end
    end
    context 'Recruitモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:recruit).macro).to eq :belongs_to
      end
    end
    context 'RecruitCommentモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:recruit_comment).macro).to eq :belongs_to
      end
    end
    context 'Messageモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:message).macro).to eq :belongs_to
      end
    end
    context 'Evaluationモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:evaluation).macro).to eq :belongs_to
      end
    end
  end
end
