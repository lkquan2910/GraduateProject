class CreateMilestones < ActiveRecord::Migration[5.2]
  def change
    create_table :milestones do |t|
      t.integer :project_id
      t.string :event
      t.date :event_time
      t.boolean :is_default, default: false

      t.timestamps
    end
  end
end
