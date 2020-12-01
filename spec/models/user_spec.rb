require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  # describe:どのようなテストコードを書いているのかを説明するための記述。do~endの間に記述し、入れ子構造をとる
  describe 'ユーザー新規登録' do
    # describeで条件分岐させたい時にcontextを用いる
    context '新規登録がうまくいかないとき' do
      # it:「どのような結果になることを試しているのか」を記述。これらのitに記述するものは、exampleと言う
      it 'nicknameが空だと登録できない' do
        # ①保存するデータのインスタンスを引っ張ってきてから
        # user = FactoryBot.build(:user)
        # exapmleの内容を定義
        @user.nickname = ''
        # ②確認 valid?:データが正しく保存される場合はtrueを、保存されない場合はfalseを返す。また、保存されない場合は「なぜ保存されないのか」のエラーメッセージも生成
        @user.valid?
        # ③エラーメッセージが正しいか確認
        # ここで binding.pry しテスト実行。途中で停止するので // モデル名.errors // でエラーを呼んで続けて //.full_messages // 実行しエラーメッセージを出力
        # expect(X).to include(Y) => 「Xの中にYという文字列が含まれているかどうか」を確認するマッチャ(= expectの中の記述と、結果とのつながりを表現するもの)
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'password_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank", 'First name kana is invalid')
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank", 'Last name kana is invalid')
      end

      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

      it 'passwordが半角英数混合でないと登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'passwordが半角英数混合でないと登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'passwordが6字以上でないと登録できない' do
        @user.password = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      # 一意性に関しては、FactoryBot を使用するとエラーオブジェクト(user.errors)が得られないので使用しない書き方に。
      it 'メールアドレスが重複していると登録できない' do
        # あらかじめ、test@mail.comというメールアドレスをもつデータをDBに用意
        FactoryBot.create(:user, email: 'test@mail.com')
        @user = FactoryBot.build(:user, email: 'test@mail.com')
        @user.valid?
        expect(@user.errors.full_messages).to include('Email has already been taken')
      end

      it 'first_nameは全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        # 意図的に半角入力を行いエラーを発生
        @user.first_name = 'ｱｲｳｴｵ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end

      it 'last_nameは全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.last_name = 'ｱｲｳｴｵ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end

      it 'first_name_nakaは全角（カタカナ）でないと登録できない' do
        # 意図的にひらがな入力を行いエラーを発生
        @user.first_name_kana = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end

      it 'last_name_nakaは全角（カタカナ）でないと登録できない' do
        # 意図的にひらがな入力を行いエラーを発生
        @user.last_name_kana = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
    end

    context '新規登録がうまくいくとき' do
      it 'nickname,email,password,password_confirmation,first_name,last_name,first_name_kana,last_name_kana,birthdayが存在すれば登録できる' do
        # 「expect(インスタンス).to be_valid」：expectのインスタンスが正しく保存されることを判断
        expect(@user).to be_valid
      end

      it 'passwordが半角英数字混合であれば登録できる' do
        @user.password = 'a12345'
        expect(@user).to be_valid
      end

      it 'passwordが6文字以上であれば登録できる' do
        @user.password = 'a12345'
        expect(@user).to be_valid
      end

      it 'first_nameが全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @user.first_name = '太郎'
        expect(@user).to be_valid
      end

      it 'last_nameが全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @user.last_name = '山田'
        expect(@user).to be_valid
      end

      it 'first_name_kanaが全角（カタカナ）であれば登録できる' do
        @user.first_name_kana = 'タロウ'
        expect(@user).to be_valid
      end

      it 'last_name_kanaが全角（カタカナ）であれば登録できる' do
        @user.last_name_kana = 'ヤマダ'
        expect(@user).to be_valid
      end
    end
  end
end
