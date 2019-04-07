class VotesController < ApplicationController
  before_action :find_issue
  before_action :find_vote, only: [:destroy]


  def create
    if current_user != nil
      if already_voted?
        flash[:notice] = "You can't vote more than once"
      else
        @issue.votes.create(user_id: current_user.id)
      end
    else
      flash[:notice] = "Cannot vote if you're not logged in"
    end
    redirect_to issue_path(@issue)
  end

  def destroy
    if !(already_voted?)
      flash[:notice] = "Cannot unvote"
    else
      @vote.destroy
    end
    redirect_to issue_path(@issue)
  end

  private
  def find_issue
    @issue = Issue.find(params[:issue_id])
  end

  def find_vote
   @vote = @issue.votes.find(params[:id])
  end

  def already_voted?
  Vote.where(user_id: current_user.id, issue_id:
    params[:issue_id]).exists?
  end
end


