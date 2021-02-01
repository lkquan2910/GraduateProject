class CreateLegalDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :legal_documents do |t|
      t.integer :project_id
      t.integer :doc_type
      t.string :doc

      t.timestamps
    end
  end
end
