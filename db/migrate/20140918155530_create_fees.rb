class CreateFees < ActiveRecord::Migration
  def change
    create_table :fees do |t|
      t.integer :month
      t.float :interest
      t.float :amortization
      t.float :payment
      t.float :balance
      t.references :credit_plan, index: true

      t.timestamps
    end
  end
end
