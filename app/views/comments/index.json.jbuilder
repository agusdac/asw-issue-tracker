json.comments @comments do |comment|
    json.commentId comment.id
    json.content comment.content
    json.userId comment.user_id
    json.createdAt comment.created_at
end