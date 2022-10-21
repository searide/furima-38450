require 'rails_helper'

RSpec.describe PurchaseForm, type: :model do
  describe '配送先情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_form = FactoryBot.build(:purchase_form, user_id: user.id, item_id: item.id)
    end

    context '配送先情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@purchase_form).to be_valid
      end
      it '建物名が空でも保存できる' do
        @purchase_form.building = nil
        expect(@purchase_form).to be_valid
      end
    end
    context '配送先情報の保存ができないとき' do
      it 'user_idが空だと保存できない' do
        @purchase_form.user_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと保存できない' do
        @purchase_form.item_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Item can't be blank")
      end
      it '郵便番号が空だと保存できない' do
        @purchase_form.postcode = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Postcode can't be blank",
                                                               'Postcode is invalid. Include hyphen(-)')
      end
      it '郵便番号にハイフンがないと保存できない' do
        @purchase_form.postcode = 1_234_567
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
      end
      it '都道府県が「---」だと保存できない' do
        @purchase_form.prefecture_id = 0
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県が空だと保存できない' do
        @purchase_form.prefecture_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと保存できない' do
        @purchase_form.city = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できない' do
        @purchase_form.block = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Block can't be blank")
      end
      it '電話番号が空だと保存できない' do
        @purchase_form.phone_number = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にハイフンがあると保存できない' do
        @purchase_form.phone_number = '123-1234-1234'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上あると保存できない' do
        @purchase_form.phone_number = 12_345_678_910_123_111
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Phone number is invalid')
      end
      it 'トークンが空だと保存できない' do
        @purchase_form.token = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
