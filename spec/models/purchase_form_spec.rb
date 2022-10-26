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
        expect(@purchase_form.errors.full_messages).to include("Userを入力してください")
      end
      it 'item_idが空だと保存できない' do
        @purchase_form.item_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Itemを入力してください")
      end
      it '郵便番号が空だと保存できない' do
        @purchase_form.postcode = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("郵便番号を入力してください", "郵便番号はハイフンを含めて入力してください")
      end
      it '郵便番号にハイフンがないと保存できない' do
        @purchase_form.postcode = 1_234_567
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("郵便番号はハイフンを含めて入力してください")
      end
      it '都道府県が「---」だと保存できない' do
        @purchase_form.prefecture_id = 0
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("都道府県を選択してください")
      end
      it '都道府県が空だと保存できない' do
        @purchase_form.prefecture_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("都道府県を入力してください", "都道府県を選択してください")
      end
      it '市区町村が空だと保存できない' do
        @purchase_form.city = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("市区町村を入力してください")
      end
      it '番地が空だと保存できない' do
        @purchase_form.block = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が空だと保存できない' do
        @purchase_form.phone_number = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("電話番号を入力してください", "電話番号が無効です")
      end
      it '電話番号にハイフンがあると保存できない' do
        @purchase_form.phone_number = '123-1234-1234'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("電話番号が無効です")
      end
      it '電話番号が12桁以上あると保存できない' do
        @purchase_form.phone_number = 12_345_678_910_123_111
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("電話番号が無効です")
      end
      it 'トークンが空だと保存できない' do
        @purchase_form.token = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
    end
  end
end
