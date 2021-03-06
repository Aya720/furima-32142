require 'rails_helper'

RSpec.describe Purchase, type: :model do
  before do
    # 外部キーの設定は直接行う
    @user = FactoryBot.build(:user)
    @item = FactoryBot.build(:item)

    @purchase = FactoryBot.build(:purchase)
  end

  describe '商品購入' do
    context '商品購入がうまくいくとき' do
      it 'zip、prefecture_id、city、street、phone、token、user_id、item_idが存在するとき' do
        expect(@purchase).to be_valid
      end

      it 'zipにハイフンがあること' do
        @purchase.zip = '123-4567'
        expect(@purchase).to be_valid
      end

      it 'apartmentが空でも購入できること' do
        @purchase.apartment = ''
        expect(@purchase).to be_valid
      end
    end

    context '商品購入がうまくいかないとき' do
      it 'zipが空では登録できない' do
        @purchase.zip = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Zip can't be blank")
      end

      it 'zipにハイフンがないと登録できない' do
        @purchase.zip = '1234567'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Zip is invalid")
      end
      
      it 'prefecture_idが空では登録できない' do
        @purchase.prefecture_id = 0
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Prefecture must be other than 0')
      end

      it 'cityが空では登録できない' do
        @purchase.city = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("City can't be blank")
      end

      it 'streetが空では登録できない' do
        @purchase.street = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Street can't be blank")
      end

      it 'phoneが空では登録できない' do
        @purchase.phone = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone can't be blank")
      end

      it 'phoneにハイフンがあると登録できない' do
        @purchase.phone = '111-1111-1111'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone is invalid")
      end

      it 'phoneが11桁以上だと登録できない' do
        @purchase.phone = '111111111111'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone is invalid")
      end

      it 'tokenが空では登録できない' do
        @purchase.token = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが空だと登録ができない' do
        @purchase.user_id = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空だと登録ができない' do
        @purchase.item_id = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
