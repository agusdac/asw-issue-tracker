json.extract! issue, :id, :title, :kind, :priority, :status, :assignee, :created, :created_at, :updated_at
json.url issue_url(issue, format: :json)
