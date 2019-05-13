json._links do
  json.self do
    json.href url_for(issue)
  end
  json.embedded do
    json.creator do
      json._links do
        json.self do
          json.href url_for(issue)
        end
      end
    end
  end
end

json.extract! issue, :id, :title, :kind, :priority, :status, :assignee, :created_at, :updated_at, :comments, :votes, :watches, :_links
json.url issue_url(issue, format: :json)

