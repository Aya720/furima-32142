class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # アソシエーションを組んでいるのでuserは入れない
  validates :name, :detail, :category_id, :state_id, :postage_id, :prefecture_id, :shipping_date_id, :price, :image, presence: true
  # numericality:属性に数値のみが使われているかを検証 オプションとして制約を指定 greater_than_or_equal_to =>指定された値以上 less_than_or_equal_to=>指定された値以下
  validates :price, format: { with: /\A[0-9]+\z/ }, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  # カテゴリののid:0以外のときに保存できる
  validates :category_id, :state_id, :postage_id, :prefecture_id, :shipping_date_id, numericality: { other_than: 0 }
  # Active Storageのテーブルで管理された画像ファイルのアソシエーションを記述
  # has_one_attachedメソッド:これを記述したモデルの各レコードは、指定したファイル名の値を1つ持ってこれる
  # 指定したファイル名は、そのモデルが設けたフォームから送られるパラメーターのキーにもなります。＝＞itemディレクトリのview内、form_withの中にあるimageは、ファイルを格納するキーにもなる
  has_one_attached :image
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :state, :postage, :prefecture, :shipping_date
end
