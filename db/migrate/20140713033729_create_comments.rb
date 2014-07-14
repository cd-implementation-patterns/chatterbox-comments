class CreateComments < ActiveRecord::Migration
  def change
    enable_extension "plpgsql"
    enable_extension "uuid-ossp"

    create_table :comments, id: :uuid do |t|
      t.uuid :post_id
      t.uuid :user_id
      t.text :body
      t.timestamps
    end

    add_index :comments, :post_id
    add_index :comments, :user_id
  end
end
