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
        expect(@comment.errors.full_messages).to include "Text can't be blank"
      end
      it 'ユーザーが紐付いていないとコメントは保存できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include "User must exist"
      end
      it 'コメントされている投稿が紐付いていないとコメントは保存できない' do
        @comment.post = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include "Post must exist"
      end
    end
  end

  describe 'アソシエーション' do
    let(:association) do
       described_class.reflect_on_association(target)
    end

    context 'Postモデルとの関係' do
      let(:target) { :post }
      it '多:1' do
        expect(association.macro).to eq :belongs_to
      end
      it '結合するモデルのクラス名：Post' do
        expect(association.class_name).to eq 'Post'
      end
    end

    context 'Userモデルとの関係' do
      let(:target) { :user }
      it '多:1' do
        expect(association.macro).to eq :belongs_to
      end
      it '結合するモデルのクラス名：User' do
        expect(association.class_name).to eq 'User'
      end
    end
  end
end
