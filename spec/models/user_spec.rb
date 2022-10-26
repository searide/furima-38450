require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '必要事項が入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'ニックネームが必須であること' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'メールアドレスが必須であること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'メールアドレスは、@を含む必要があること' do
        @user.email = '123.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワードは半角英数の両方を使用してください", "パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = 'ab123'
        @user.password_confirmation = 'ab123'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'パスワードは、数字のみの設定はできない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数の両方を使用してください")
      end
      it 'パスワードは、英字のみの設定はできない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数の両方を使用してください")
      end
      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'ａｂｃ１２３'
        @user.password_confirmation = 'ａｂｃ１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数の両方を使用してください")
      end
      it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
        @user.password = '123abc'
        @user.password_confirmation = '456def'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it '名字が必須であること' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前（姓）を入力してください", "お名前（姓）は全角文字で入力してください")
      end
      it '名前が必須であること' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前（名）を入力してください", "お名前（名）は全角文字で入力してください")
      end
      it '名字が全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前（姓）は全角文字で入力してください")
      end
      it '名前が全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.first_name = 'rikutaro'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前（名）は全角文字で入力してください")
      end
      it '名字カナ(全角)が必須であること' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ（姓）を入力してください", "お名前カナ（姓）は全角カナ文字で入力してください")
      end
      it '名前カナ(全角)が必須であること' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ（名）を入力してください", "お名前カナ（名）は全角カナ文字で入力してください")
      end
      it '名字カナ(全角)は、全角（カタカナ）での入力が必須であること' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ（姓）は全角カナ文字で入力してください")
      end
      it '名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do
        @user.first_name_kana = 'りくたろう'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ（名）は全角カナ文字で入力してください")
      end
      it '生年月日が必須であること' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
