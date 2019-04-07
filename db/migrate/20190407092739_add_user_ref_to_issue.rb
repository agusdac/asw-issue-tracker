class AddUserRefToIssue < ActiveRecord::Migration[5.1]
  def change
    add_reference :issues, :user, foreign_key: true
    add_reference :issues, :assignee, foreign_key: false
  end
end
