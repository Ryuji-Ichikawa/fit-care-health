require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  describe '投稿の保存' do
    context '投稿ができる場合' do
      it 'すべての項目があれば投稿できる' do
        expect(@post).to be_valid
      end
    end
    context '投稿ができない場合' do
      it 'タイトルが空では投稿できない' do
        @post.title = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("Title can't be blank")
      end
      it 'キャッチコピーが空では投稿できない' do
        @post.catch_copy = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("Catch copy can't be blank")
      end
      it 'コンセプトが空では投稿できない' do
        @post.concept = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("Concept can't be blank")
      end
      it '画像が空では投稿できない' do
        @post.image = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Image can't be blank")
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @post.user = nil
        @post.valid?
        expect(@post.errors.full_messages).to include('User must exist')
      end
    end
  end
end
