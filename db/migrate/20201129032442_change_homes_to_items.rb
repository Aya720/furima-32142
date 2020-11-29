class ChangeHomesToItems < ActiveRecord::Migration[6.0]
  def change
    rename_table :homes, :items
  end
end
