class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    drop_table :reviews
    create_table :reviews do |t|
      t.string :comment
      t.integer :rating
      t.references :list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
