require 'rails_helper'
RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  
  describe 'コメントの保存' do
    context 'コメントが保存できる場合' do
      it 'テキストがあれば保存される' do
        expect(@comment).to be_valid
      end
    end

    context 'コメントが保存できない場合' do
      it 'テキストが空だとコメントは保存できない' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include "テキストを入力してください"
      end
      it 'ユーザーが紐付いていないとコメントは保存できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include "Userを入力してください"
      end
      it 'コメントされている投稿が紐付いていないとコメントは保存できない' do
        @comment.tweet = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include "Tweetを入力してください"
      end
    end
  end
end
