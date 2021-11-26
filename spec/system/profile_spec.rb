require 'rails_helper'

describe 'プロフィール画面のテスト' do
  let(:user) { create(:user) }
  let!(:recruit) { create(:recruit, user: user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end
  context '表示内容の確認' do
    it 'URLが正しい' do
      expect(current_path).to eq '/users/' + user.nickname
    end
    it 'プロフィール編集リンクが表示される' do
      link = find_all('.btn__profile_edit')[0].native.inner_text
      expect(link).to match(/プロフィール編集/i)
    end
    it 'フォロー一覧リンクが表示される' do
      link = find_all('a')[12].native.inner_text
      expect(link).to match(/フォロー中/i)
    end
    it 'フォロワー一覧リンクが表示される' do
      link = find_all('a')[13].native.inner_text
      expect(link).to match(/フォロワー/i)
    end
  end
  context 'リンク内容の確認' do
    subject { current_path }
    it 'フォロー中を押すと、フォロー一覧画面に遷移する' do
      link = find_all('a')[12].native.inner_text
      link = link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link link
      is_expected.to eq '/users/' + user.nickname + '/followings'
    end
    it 'フォロワーを押すと、フォロワー一覧画面に遷移する' do
      link = find_all('a')[13].native.inner_text
      link = link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '').gsub(/&nbsp/, '')
      click_link link
      is_expected.to eq '/users/' + user.nickname + '/followers'
    end
    it '投稿内容を押すと、投稿詳細画面に遷移する' do
      recruit_link = find_all('a')[14].native.inner_text
      recruit_link = recruit_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link recruit_link
      is_expected.to eq '/recruit/' + recruit.id
    end
  end
end