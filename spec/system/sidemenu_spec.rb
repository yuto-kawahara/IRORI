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
    it 'ホームリンクが表示される: 左上から2番目のリンクが「ホーム」である' do
      side_menu_link = find_all('a')[1].native.inner_text
      expect(side_menu_link).to match(/ホーム/i)
    end
    it 'プロフィールリンクが表示される: 左上から3番目のリンクが「プロフィール」である' do
      side_menu_link = find_all('a')[2].native.inner_text
      expect(side_menu_link).to match(/プロフィール/i)
    end
    it '募集リンクが表示される: 左上から4番目のリンクが「募集」である' do
      side_menu_link = find_all('a')[4].native.inner_text
      expect(side_menu_link).to match(/募集/i)
    end
    it '卓報告リンクが表示される: 左上から5番目のリンクが「卓報告」である' do
      side_menu_link = find_all('a')[5].native.inner_text
      expect(side_menu_link).to match(/卓報告/i)
    end
    it 'メッセージリンクが表示される: 左上から6番目のリンクが「メッセージ」である' do
      side_menu_link = find_all('a')[6].native.inner_text
      expect(side_menu_link).to match(/メッセージ/i)
    end
    it '通知リンクが表示される: 左上から7番目のリンクが「通知」である' do
      side_menu_link = find_all('a')[7].native.inner_text
      expect(side_menu_link).to match(/通知/i)
    end
    it 'スケジュールリンクが表示される: 左上から8番目のリンクが「スケジュール」である' do
      side_menu_link = find_all('a')[8].native.inner_text
      expect(side_menu_link).to match(/スケジュール/i)
    end
    it '設定リンクが表示される: 左上から9番目のリンクが「設定」である' do
      side_menu_link = find_all('a')[9].native.inner_text
      expect(side_menu_link).to match(/設定/i)
    end
    it '募集するリンクが表示される: 左上から10番目のリンクが「募集する」である' do
      side_menu_link = find_all('a')[10].native.inner_text
      expect(side_menu_link).to match(/募集する/i)
    end
  end
  context 'リンク内容の確認' do
    subject { current_path }
    it 'サイトロゴを押すと、ホーム画面に遷移する' do
      logo_link = find('a.site_logo_link').native.inner_text
      logo_link = logo_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logo_link
      is_expected.to eq '/home'
    end
    it 'ホームリンクを押すと、ホーム画面に遷移する' do
      home_link = find_all('.side_menu__link')[0].native.inner_text
      home_link = home_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link home_link, match: :first
      is_expected.to eq '/home'
    end
    it 'プロフィールを押すと、プロフィール画面に遷移する' do
      profile_link = find_all('.side_menu__link')[1].native.inner_text
      profile_link = profile_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link profile_link
      is_expected.to eq '/users/' + user.nickname
    end
    it '募集を押すと、募集画面に遷移する' do
      recruit_link = find_all('.side_menu__link')[3].native.inner_text
      recruit_link = recruit_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link recruit_link, match: :first
      is_expected.to eq '/recruits/schedule/today'
    end
    it '卓報告を押すと、卓報告画面に遷移する' do
      evaluation_link = find_all('.side_menu__link')[4].native.inner_text
      evaluation_link = evaluation_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link evaluation_link
      is_expected.to eq '/users/' + user.nickname + '/evaluations'
    end
    it 'メッセージを押すと、メッセージ画面に遷移する' do
      message_link = find_all('.side_menu__link')[5].native.inner_text
      message_link = message_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link message_link
      is_expected.to eq '/messages'
    end
    it '通知を押すと、通知画面に遷移する' do
      notice_link = find_all('.side_menu__link')[6].native.inner_text
      notice_link = notice_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link notice_link, match: :first
      is_expected.to eq '/notifications'
    end
    it 'スケジュールを押すと、スケジュール画面に遷移する' do
      schedule_link = find_all('.side_menu__link')[7].native.inner_text
      schedule_link = schedule_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link schedule_link
      is_expected.to eq '/users/' + user.nickname + '/schedule'
    end
    it '設定を押すと、設定画面に遷移する' do
      setting_link = find_all('.side_menu__link')[8].native.inner_text
      setting_link = setting_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link setting_link
      is_expected.to eq '/setting'
    end
    it '募集するを押すと、募集新規投稿画面に遷移する' do
      recruit_new_link = find('.btn__recruit').native.inner_text
      recruit_new_link = recruit_new_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link recruit_new_link
      is_expected.to eq '/recruits/new'
    end
  end
end