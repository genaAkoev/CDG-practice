class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.integer :user_id, index: true
      t.string :title
      t.text :description
      t.string :grade

      t.timestamps
    end
  end
end
