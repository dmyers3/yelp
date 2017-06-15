class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :description
      t.integer :business_id
      t.timestamps
    end
  end
end
