class CreateOrders < ActiveRecord::Migration[5.2]
  def change
      create_table :orders do |t|
      t.string :claim_num
      t.string :contact_name

      t.timestamps null: false
    end
  end
end
