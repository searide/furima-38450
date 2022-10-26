require 'rails_helper'

describe Item, type: :model do
  before do
    @item = FactoryBot.create(:item)
  end

  describe '商品出品' do
    context '商品出品がうまくいくとき' do
      it '全ての項目が入力されていれば出品ができる' do
        expect(@item).to be_valid
      end
    end
    context '商品出品がうまくいかないとき' do
      it 'ユーザー登録している人でないと出品できない' do
        @item.user_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Userを入力してください")
      end
      it 'imageが空では登録されない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it 'nameが空では登録されない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it 'descriptionが空では登録されない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'category_idが空では登録されない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください", "カテゴリーを選択してください")
      end
      it 'condition_idが空では登録されない' do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください", "商品の状態を選択してください")
      end
      it 'delivery_cost_idが空では登録されない' do
        @item.delivery_cost_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください", "配送料の負担を選択してください")
      end
      it 'prefecture_idが空では登録されない' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください", "発送元の地域を選択してください")
      end
      it 'scheduled_delivery_idが空では登録されない' do
        @item.delivery_date_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください", "発送までの日数を選択してください")
      end
      it 'category_idで0が選択された場合は登録されない' do
        @item.category_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
      end
      it 'condition_idで0が選択された場合は登録されない' do
        @item.condition_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を選択してください")
      end
      it 'delivery_cost_idで0が選択された場合は登録されない' do
        @item.delivery_cost_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を選択してください")
      end
      it 'prefecture_idで0が選択された場合は登録されない' do
        @item.prefecture_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選択してください")
      end
      it 'delivery_date_idで0が選択された場合は登録されない' do
        @item.delivery_date_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選択してください")
      end
      it 'priceが空では登録されない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください", "販売価格は数値で入力してください")
      end
      it 'priceが半角数字以外では登録できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は数値で入力してください")
      end
      it 'priceが300より少ないと登録できない' do
        @item.price = '50'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は300以上の値にしてください")
      end
      it 'priceが9999999より多いと登録できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は9999999以下の値にしてください")
      end
    end
  end
end
