json.extract! issue, :id, :title, :type, :priority, :status, :assignee, :created, :created_at, :updated_at
json.url issue_url(issue, format: :json)
