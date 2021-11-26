require 'rails_helper'

describe 'トップ画面のテスト' do
  before do
    visit root_path
  end

  context '表示内容の確認' do
    it 'URLが正しい' do
      expect(current_path).to eq '/'
    end
    it 'Sign Upリンクが表示される: 左上から1番目のリンクが「新規登録」である' do
      sign_up_link = find_all('a')[0].native.inner_text
      expect(sign_up_link).to match(/新規登録/i)
    end
    it 'Sign Upリンクの内容が正しい' do
      sign_up_link = find_all('a')[0].native.inner_text
      expect(page).to have_link sign_up_link, href: new_user_registration_path
    end
    it 'Log inリンクが表示される: 左上から2番目のリンクが「ログイン」である' do
      log_in_link = find_all('a')[1].native.inner_text
      expect(log_in_link).to match(/ログイン/i)
    end
    it 'Log inリンクの内容が正しい' do
      log_in_link = find_all('a')[1].native.inner_text
      expect(page).to have_link log_in_link, href: new_user_session_path
    end
  end
end