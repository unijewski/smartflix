class CreateExternalRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :external_ratings do |t|
      t.string :source_name, null: false
      t.float :rating, null: false
      t.references :movie, foreign_key: true, null: false

      t.timestamps
    end
  end
end
