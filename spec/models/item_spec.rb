require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  # describe:どのようなテストコードを書いているのかを説明するための記述。do~endの間に記述し、入れ子構造をとる
  describe '商品登録' do
    # describeで条件分岐させたい時にcontextを用いる
    context '商品登録がうまくいかないとき' do
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'nameが空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'detailが空では登録できない' do
        @item.detail = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Detail can't be blank")
      end

      it 'category_idが空では登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 0')
      end

      it 'state_idが空では登録できない' do
        @item.state_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('State must be other than 0')
      end

      it 'postage_idが空では登録できない' do
        @item.postage_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Postage must be other than 0')
      end

      it 'shipping_date_idが空では登録できない' do
        @item.shipping_date_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping date must be other than 0')
      end

      it 'priceが空では登録できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", 'Price is invalid', 'Price is not a number')
      end

      it '価格の範囲が、300円以下は登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it '価格の範囲が、9,999,999円以上は登録できない' do
        @item.price = 99_999_999
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it '販売価格は半角数字でないと登録できない' do
        @item.price = '１１１１'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it 'userが紐付いていないと保存できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end

    context '商品登録がうまくいくとき' do
      it 'image、name、detail、category_id、state_id、postage_id、prefecture_id、shipping_date_id、price、imageが存在するとき' do
        expect(@item).to be_valid
      end

      it '価格の範囲が、300円以上であること' do
        @item.price = 300
        expect(@item).to be_valid
      end

      it '価格の範囲が、9,999,999円以内であること' do
        @item.price = 9_999_999
        expect(@item).to be_valid
      end
    end
  end
end
