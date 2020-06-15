json.countWatches @count_watches
json.watches @watches do |watch|
    json.watchId watch.id
    json.issueId watch.issue_id
    json.userId watch.user_id
    json.createdAt watch.created_at
end