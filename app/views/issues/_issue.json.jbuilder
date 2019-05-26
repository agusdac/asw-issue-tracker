json.extract! issue, :id, :title, :description, :kind, :priority, :status, :assignee, :user_id, :created_at, :updated_at, :comments, :votes, :watches
json.url issue_url(issue, format: :json)

json._links do
  json.self do
    json.href url_for(issue)
  end
  json.embedded do
    json.creator do
      json._links do
        json.self do
          json.href url_for(issue.user)
        end
      end
    end
    json.comments do
      json._links do
        json.self do
          json.href url_for(issue) + "/comments"
        end
      end
    end
  end
end


