class CreatePaymentSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_schedules do |t|
      t.integer :project_id
      t.integer :label_schedule
      t.string :name
      t.decimal :pay, precision: 5, scale: 2

      t.timestamps
    end
  end
end
