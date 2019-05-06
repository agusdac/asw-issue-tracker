class CommentsController < ApplicationController
    before_action :find_issue
    before_action :find_comment, only: [:destroy, :edit, :update, :comment_owner, :show]
    before_action :comment_owner, only: [:destroy, :edit, :update]
    
    # GET /issues/:issue_id/comments
    # GET /issues/:issue_id/comments.json
    def index
        @comments = Comment.all
    end

    # GET /issues/:issue_id/comments/:id
    # GET /issues/:issue_id/comments/:id.json
    def show
    end

    def create
        if current_user != nil
            if !params[:comment][:content].blank?
                @comment = @issue.comments.create(params[:comment].permit(:content))
                @comment.user_id = current_user.id
                if @comment.save
                    redirect_to issue_path(@issue)
                else
                    render 'new'
                end
            else
                redirect_to issue_path(@issue)
            end
        else
            redirect_to @issue, notice: 'You must be logged in' 
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
