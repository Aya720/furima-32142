class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #バリデーション:データベースに保存する際、投稿された内容を検証し、保存するかどうかをチェックする。 save,create,updateなどが動く前に検証作業を行う
  #presence:指定された属性が「空でない」ことを確認するヘルパーメソッド。値が空欄でもホワイトスペースでもないことを確認するために、内部でblank?メソッドを使っている
  #presence: true => カラムにちゃんと値が入っているかを検証。このカラムに何も入っていないときは保存されない。「validates_presence_of:カラム名」に書き換え可
  #absence: true => presence: true の逆で「空であるか」。「validates_absence_of:カラム名」に書き換え可
  #  ※※email,passwordはデフォルトで保存できるようになっている※※
  validates :nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday, presence: true

  #uniqueness:値が一意（unique）であり重複していないかを検証します。メールアドレスなど重複しては困るときに使う
  #「validates :カラム名, uniqueness: true」カラムにすでに存在している内容と同じものがあるかどうかを検証する。すでに値が存在していれば保存されません。「validates_uniqueness_of :カラム名」に書き換え可
  validates :email, uniqueness: true

  #値の長さを検証。{ minimum:  }でオプションを指定。4つある。minimum = 最小値を指定 /maximum = 最大値を指定 /in = 範囲を指定 /is = 文字数を指定 「validates_length_of :カラム名, maximum: 」に書き換え可
  #format:withオプションに指定した 正規表現=文字列の属性 と一致するかどうかを調べる。「validates :カラム名, format: { with: 正規表現}」赤字：パスワードに半角英数字だけ許可する
  validates :password, length: { minimum: 6 }, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i }, confirmation: true
 
  #名前 format: { with: 全角（漢字・ひらがな・カタカナ） }
  validates :first_name, :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/ }

  #フリガナ format: { with: 全角（カタカナ） }
  validates :first_name_kana, :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }

  has_many :items
  has_many :orders

end
