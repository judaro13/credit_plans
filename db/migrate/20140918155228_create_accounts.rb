class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name,              null: false, default: ""
      t.string :path,              null: false, default: ""

      t.timestamps
    end
  end
end
