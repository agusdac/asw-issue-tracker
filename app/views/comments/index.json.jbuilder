json.comments @comments do |comment|
    json.commentId comment.id
    json.content comment.content
    json.userId comment.user_id
    json.createdAt comment.created_at
    json._links do
        json.self do
            json.href url_for(comment.issue) + "/comments"
        end
        json.embedded do
            json.creator do
                json._links do
                    json.self do
                        json.href url_for(comment.user)
                    end
                end
            end
            json.comments do
                json._links do
                    json.self do
                        json.href url_for(comment.issue)
                    end
                end
            end
        end
    end
end

