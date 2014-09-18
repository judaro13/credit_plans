class CreateCreditPlans < ActiveRecord::Migration
  def change
    create_table :credit_plans do |t|
      t.string :document,              null: false, default: ""
      t.date :birth_date,              null: false, default: Time.now
      t.float :amount,              null: false, default: 0.0
      t.string :state,              null: false, default: "En Proceso"
      t.integer :risk_level
      t.references :account, index: true
      t.references :credit_line, index: true

      t.timestamps
    end
  end
end
