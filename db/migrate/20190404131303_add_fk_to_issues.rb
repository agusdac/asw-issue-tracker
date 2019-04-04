class AddFkToIssues < ActiveRecord::Migration[5.1]
  def change
    add_reference :issues, :user, index: true
    add_foreign_key :asignee, :users
  end
end