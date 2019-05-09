json.countVotes @count_votes
json.votes @votes do |vote|
    json.voteId vote.id
    json.issueId vote.issue_id
    json.userId vote.user_id
    json.createdAt vote.created_at
end