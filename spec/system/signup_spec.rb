require 'rails_helper'

describe 'ユーザ新規登録のテスト' do
  before do
    visit new_user_registration_path
  end

  context '表示内容の確認' do
    it 'URLが正しい' do
      expect(current_path).to eq '/users/signup'
    end
    it '「Sign up」と表示される' do
      expect(page).to have_content '新規登録'
    end
    it 'nameフォームが表示される' do
      expect(page).to have_field 'user[nickname]'
    end
    it 'emailフォームが表示される' do
      expect(page).to have_field 'user[email]'
    end
    it 'passwordフォームが表示される' do
      expect(page).to have_field 'user[password]'
    end
    it 'password_confirmationフォームが表示される' do
      expect(page).to have_field 'user[password_confirmation]'
    end
    it '新規登録ボタンが表示される' do
      expect(page).to have_button '新規登録'
    end
  end

  context '新規登録成功のテスト' do
    before do
      fill_in 'user[nickname]', with: Faker::Lorem.characters(number: 50)
      fill_in 'user[email]', with: Faker::Internet.email
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
    end

    it '正しく新規登録される' do
      expect { click_button '新規登録' }.to change(User.all, :count).by(1)
    end
    it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
      click_button '新規登録'
      expect(current_path).to eq '/users/' + User.last.nickname.to_s
    end
  end

  context '新規登録失敗のテスト' do
    before do
      fill_in 'user[nickname]', with: ''
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      fill_in 'user[password_confirmation]', with: ''
    end

    it '新規登録に失敗し、新規登録画面にリダイレクトされる' do
      expect(current_path).to eq '/users/signup'
    end
  end
end