class CreateIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :issues do |t|
      t.string :title
      t.string :kind
      t.string :priority
      t.string :status
      t.string :assignee
      t.date :created
      t.string :description
      t.integer :assignee_id

      t.timestamps
    end
  end
end
