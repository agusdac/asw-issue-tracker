class WatchesController < ApplicationController
  before_action :find_issue
  before_action :find_watch, only: [:destroy]
  skip_before_action :verify_authenticity_token

  def index
    @count_watches = @issue.watches.count
    @watches = @issue.watches
  end

  def create
    @user_aux = authenticate
    if @user_aux != nil
      if already_watched?
        flash[:notice] = "You can't watch more than once"
      else
        @issue.watches.create(user_id: @user_aux.id)
        flash[:notice] = "You are now watching issue #{@issue.id}"
      end
    else
      flash[:notice] = "Cannot watch if you're not logged in"
    end
    redirect_back fallback_location: root_path, status: :see_other

  end


  def destroy
    @user_aux = authenticate
    if !(already_watched?)
      flash[:notice] = "Cannot unwatch"
    else
      @watch.destroy
    end
    redirect_back fallback_location: root_path, status: :see_other
  end

  private
  def find_issue
    @issue = Issue.find(params[:issue_id])
  end

  def find_watch
    @watch = @issue.watches.find(params[:id])
  end



  def already_watched?
  Watch.where(user_id: @user_aux.id, issue_id:
    params[:issue_id]).exists?
  end

end
