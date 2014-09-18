class CreateCreditLines < ActiveRecord::Migration
  def change
    create_table :credit_lines do |t|
      t.string :name,              null: false, default: ""
      t.float :annual_interest,              null: false, default: 0.0
      t.references :account, index: true

      t.timestamps
    end
  end
end
