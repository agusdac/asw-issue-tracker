class CommentsController < ApplicationController
    before_action :find_issue
    before_action :find_comment, only: [:destroy, :edit, :update, :comment_owner]
    before_action :comment_owner, only: [:destroy, :edit, :update]

    def create
        @comment = @issue.comments.create(params[:comment].permit(:content))
        @comment.user_id = current_user.id
        @comment.save

        if @comment.save
            redirect_to issue_path(@issue)
        else
            render 'new'
        end
    end

    def destroy
        @comment.destroy
        redirect_to issue_path(@issue)
    end

    def edit
    end

    def update
        if @comment.update(params[:comment].permit(:content))
            redirect_to issue_path(@issue)
        else 
            render 'edit'
        end
    end

    private
    def find_issue
        @issue = Issue.find(params[:issue_id])
    end

    private 
    def find_comment
        @comment = @issue.comments.find(params[:id])
    end

    def comment_owner
        unless current_user.id == @comment.user_id
            flash[:notice] = "You shall not pass!"
            redirect_to @issue
        end
    end
    
end
