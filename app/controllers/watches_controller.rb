class WatchesController < ApplicationController
    
  before_action :find_watch, only: [:destroy]
  before_action :find_issue

  def create
      if already_watched?
        flash[:notice] = "You can't watch more than once"
      else
        @issue.watches.create(user_id: current_user.id)
      end
      #redirect_to issue_path(@issue)
  end
 
  
  def destroy
    if !(already_watched?)
      flash[:notice] = "Cannot unwatch"
    else
      @watch.destroy
    end
    redirect_to issue_path(@issue)
  end
  
  private
  def find_issue
    @issue = Issue.find(params[:issue_id])
  end
  
  def find_watch
    @watch = Issue.watches.find(params[:issue_id])
  end
  
  
  
  def already_watched?
  Watch.where(user_id: current_user.id, issue_id:
    params[:issue_id]).exists?
  end
    
end
