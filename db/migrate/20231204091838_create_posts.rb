class CreatePosts < ActiveRecord::Migration[6.1]
  def change
     create_table :posts do |t|
     t.string :image_id
     t.text :caption
     t.integer :customer_id
     t.timestamps
    end
  end
end
