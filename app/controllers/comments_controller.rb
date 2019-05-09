class CommentsController < ApplicationController
    before_action :find_issue
    before_action :find_comment, only: [:destroy, :edit, :update, :comment_owner, :show]
    before_action :comment_owner, only: [:destroy, :edit, :update]
    skip_before_action :verify_authenticity_token
    
    # GET /issues/:issue_id/comments
    # GET /issues/:issue_id/comments.json
    def index
        @comments = @issue.comments
    end

    # GET /issues/:issue_id/comments/:id
    # GET /issues/:issue_id/comments/:id.json
    def show
    end

    def create
        @user_aux = authenticate
        if @user_aux != nil
            if !params[:comment][:content].blank?
                @comment = @issue.comments.create(params[:comment].permit(:content))
                @comment.user_id = @user_aux.id
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
        redirect_to @issue, status: :see_other
    end

    def edit
    end

    def update
        if @comment.update(params[:comment].permit(:content))
            redirect_to @issue, status: :see_other
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
        @user_aux = authenticate
        unless @user_aux.id == @comment.user_id
            flash[:notice] = "You shall not pass!"
            redirect_to @issue
        end
    end
    
end
