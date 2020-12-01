require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  # describe:どのようなテストコードを書いているのかを説明するための記述。do~endの間に記述し、入れ子構造をとる
  describe 'ユーザー新規登録' do
    # it:「どのような結果になることを試しているのか」を記述。これらのitに記述するものは、exampleと言う
    it "nicknameが空だと登録できない" do
      # ①保存するデータのインスタンスを引っ張ってきてから
      # user = FactoryBot.build(:user)
      # exapmleの内容を定義
      @user.nickname = ""
      # ②確認 valid?:データが正しく保存される場合はtrueを、保存されない場合はfalseを返す。また、保存されない場合は「なぜ保存されないのか」のエラーメッセージも生成
      @user.valid?
      # ③エラーメッセージが正しいか確認
      # ここで binding.pry しテスト実行。途中で停止するので // モデル名.errors // でエラーを呼んで続けて //.full_messages // 実行しエラーメッセージを出力
      # expect(X).to include(Y) => 「Xの中にYという文字列が含まれているかどうか」を確認するマッチャ(= expectの中の記述と、結果とのつながりを表現するもの)
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it "emailが空では登録できない" do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "passwordが空では登録できない" do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "password_confirmationが空では登録できない" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "first_nameが空では登録できない" do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "last_nameが空では登録できない" do
      @user.last_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "first_name_kanaが空では登録できない" do
      @user.first_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana is invalid")
    end

    it "last_name_kanaが空では登録できない" do
      @user.last_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank", "Last name kana is invalid")
    end

    it "birthdayが空では登録できない" do
      @user.birthday = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end

    it 'passwordが半角英数混合でないと登録できない' do
      @user.password = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end

    it 'passwordが半角英数混合でないと登録できない' do
      @user.password = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end

    it 'passwordが6字以上でないと登録できない' do
      @user.password = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

  end
end
