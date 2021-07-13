require 'rails_helper'

RSpec.describe '新規投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.build(:post)
  end
  context '新規投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      # 新規投稿ページへのボタンがあることを確認する
      # 投稿ページに移動する
      # フォームに情報を入力する
      # 送信するとPostモデルのカウントが1上がることを確認する
      # 投稿完了ページに遷移することを確認する
      # 「投稿が完了しました」の文字があることを確認する
      # トップページに遷移する
      # トップページには先ほど投稿した内容が存在することを確認する（画像）
      # トップページには先ほど投稿した内容が存在することを確認する（テキスト）
    end
  end
  context '新規投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      # 新規投稿ページへのボタンがないことを確認する
    end
  end
end
