require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'アソシエーション' do
    let(:association) do
       described_class.reflect_on_association(target)
    end

    context 'Postモデルとの関係' do
      let(:target) { :posts }
      it '1:多' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラス名：Post' do
        expect(association.class_name).to eq 'Post'
      end
    end

    context 'TagTweetモデルとの関係' do
      let(:target) { :tag_maps }
      it '1:多' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラス名：TagMaps' do
        expect(association.class_name).to eq 'TagMap'
      end
    end
  end
end
