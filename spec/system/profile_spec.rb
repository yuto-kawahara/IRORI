require 'rails_helper'

describe 'サイドメニューのテスト' do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end
  context '表示内容の確認' do
    it 'ホームリンクが表示される: 左上から1番目のリンクが「IRORI」である' do
      side_menu_link = find_all('a')[0].native.inner_text
      expect(side_menu_link).to match(//i)
    end
  end
  context 'リンク内容の確認' do
    subject { current_path }
    it '募集するを押すと、募集新規投稿画面に遷移する' do
      recruit_new_link = find('.btn__recruit').native.inner_text
      recruit_new_link = recruit_new_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link recruit_new_link
      is_expected.to eq '/recruits/new'
    end
  end
end