require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system do
  before do
    @post = FactoryBot.create(:post)
    @comment = FactoryBot.build(:comment)
  end

  # ログインしていないユーザーは、コメント投稿フォームが表示されないことを確認済み

  it 'ログインしたユーザーは投稿詳細ページでコメントを投稿できる' do
    # ログインする
    sign_in(@post.user)
    # ツイート詳細ページに遷移する
    visit post_path(@post)
    # フォームに情報を入力する
    fill_in 'text', with: @comment.text
    # コメントを送信すると、Commentモデルのカウントが1上がる
    expect  do
      find('input[name="commit"]').click
      sleep 1
    end.to change {Comment.count}.by(1)
    # コメント内容と「あなたのコメントです」と表示されている
    visit post_path(@post)
    expect(page).to have_content(@comment.text)
    expect(page).to have_content('あなた')
  end
end
