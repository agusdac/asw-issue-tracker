json.extract! issue, :id, :title, :kind, :priority, :status, :assignee, :created_at, :updated_at, :comments, :votes, :watches
json.url issue_url(issue, format: :json)
