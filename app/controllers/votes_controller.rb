class VotesController < ApplicationController
  before_action :find_issue
  before_action :find_vote, only: [:destroy]
  skip_before_action :verify_authenticity_token

  def index
    @count_votes = @issue.votes.count
    @votes = @issue.votes
  end

  def create
    @user_aux = authenticate
    if @user_aux != nil
      if already_voted?
        flash[:notice] = "You can't vote more than once"
      else
        @issue.votes.create(user_id: @user_aux.id)
      end
    else
      flash[:notice] = "Cannot vote if you're not logged in"
    end
    redirect_to issue_path(@issue)
  end

  def destroy
    @user_aux = authenticate
    if !(already_voted?)
      flash[:notice] = "Cannot unvote"
    else
      @vote.destroy
    end
    redirect_to issue_path(@issue), status: :see_other
  end

  private
  def find_issue
    @issue = Issue.find(params[:issue_id])
  end

  def find_vote
   @vote = @issue.votes.find(params[:id])
  end

  def already_voted?
  Vote.where(user_id: @user_aux.id, issue_id:
    params[:issue_id]).exists?
  end
end


