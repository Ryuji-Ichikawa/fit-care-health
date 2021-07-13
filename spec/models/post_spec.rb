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

  describe 'アソシエーション' do
    let(:association) do
       described_class.reflect_on_association(target)
    end

    context 'Commentモデルとの関係' do
      let(:target) { :comments }
      it '1:多' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラス名：Comment' do
        expect(association.class_name).to eq 'Comment'
      end
    end

    context 'Likeモデルとの関係' do
      let(:target) { :likes }
      it '1:多' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラス名：Like' do
        expect(association.class_name).to eq 'Like'
      end
    end

    context 'Tagモデルとの関係' do
      let(:target) { :tags }
      it '1:多' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラス名：TagTweet' do
        expect(association.class_name).to eq 'Tag'
      end
    end

    context 'TagMapモデルとの関係' do
      let(:target) { :tag_maps }
      it '1:多' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラス名：TagMap' do
        expect(association.class_name).to eq 'TagMap'
      end
    end

    context 'Userモデルとの関係' do
      let(:target) { :user }
      it '1:1' do
        expect(association.macro).to eq :belongs_to
      end
      it '結合するモデルのクラス：User' do
        expect(association.class_name).to eq 'User'
      end
    end
  end
end
