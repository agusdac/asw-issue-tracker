class AddFkToIssues < ActiveRecord::Migration[5.1]
  def change
    add_reference :issues, :user, index: true
    add_reference :issues, :assignee, foreign_key: true
  end
end
