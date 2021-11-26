require 'rails_helper'

describe 'ユーザログイン' do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
  end

  context '表示内容の確認' do
    it 'URLが正しい' do
      expect(current_path).to eq '/users/login'
    end
    it '「ログイン」と表示される' do
      expect(page).to have_content 'ログイン'
    end
    it 'emailフォームは表示される' do
      expect(page).to have_field 'user[email]'
    end
    it 'passwordフォームが表示される' do
      expect(page).to have_field 'user[password]'
    end
    it 'ログインボタンが表示される' do
      expect(page).to have_button 'ログイン'
    end
  end

  context 'ログイン成功のテスト' do
    before do
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    it 'ログイン後のリダイレクト先が、ログインしたユーザの詳細画面になっている' do
      expect(current_path).to eq '/users/' + user.nickname
    end
  end

  context 'ログイン失敗のテスト' do
    before do
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      click_button 'ログイン'
    end

    it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
      expect(current_path).to eq '/users/login'
    end
  end
end