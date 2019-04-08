class AddFkToIssues < ActiveRecord::Migration[5.1]
  def change
    add_reference :issues, :user, index: true
    add_reference :issues, :assignee, class_name => 'User', index: true
  end
end
