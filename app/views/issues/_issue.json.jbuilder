
json.extract! issue, :id, :title, :kind, :priority, :status, :assignee, :created_at, :updated_at, :comments, :votes, :watches
json.url issue_url(issue, format: :json)

json._links do
  json.self do
    json.href url_for(issue)
  end
  json.embedded do
    json.creator do
      json.self do
        json.href url_for(issue)
      end
    end
  end
end


