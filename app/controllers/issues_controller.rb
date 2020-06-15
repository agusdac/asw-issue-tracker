class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  # GET /issues
  # GET /issues.json
  def index
     
    #status filters
    if params[:status] == "new"
      @issues = Issue.where(status: ["new"])
    elsif params[:status] == "open" or params[:status] == "new"
      @issues = Issue.where(status: ["open", "new"])
    elsif params[:status].present?
      @issues = Issue.where(status: [params[:status]])
    #kind filters
    elsif params[:kind].present?
      @issues = Issue.where(kind: [params[:kind]])
    #priority filters
    elsif params[:priority].present?
      @issues = Issue.where(priority: [params[:priority]])
    #user filters
    elsif params[:assignee_id].present?
      @issues = Issue.where(assignee_id: [params[:assignee_id]])
    #myissues
    elsif current_user.present? and params[:user_id] == "m"
      @issues = Issue.where(user_id: current_user.id)
    elsif current_user.present? and params[:user_id] == "w"
      
      @issues = Issue.joins(:watches).where(['watches.issue_id = issues.id AND watches.user_id = ?', current_user.id])
      
    else
      @issues = Issue.all
    end
    
    if params[:sort].present?
      if params[:dir] == "down"
        @issues = @issues.order(params[:sort]).reverse_order
      else
        @issues = @issues.order(params[:sort])
      end
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    @comments = Comment.where(issue_id: @issue).order("created_at ASC")
  end

  # GET /issues/new
  def new
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)
    @issue.status = "new";
    
     if @issue.file.present?
        @comment = @issue.comments.new(content: "-- File attached", user_id: @issue.user.id)
        @comment.save!
     end
     
    respond_to do |format|
      @user_aux = authenticate
      if (@user_aux.nil?)
        format.json { render json: @issue.errors, status: 403}
      else
        @issue.user_id = @user_aux.id;
        if @issue.save
          format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
          format.json { render :show, status: :created, location: @issue }
        else
          format.html { render :new }
          format.json { render json: @issue.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      @user_aux = authenticate
      if (!@user_aux.nil? and @user_aux.id == @issue.user_id)
        if @issue.update(issue_params)
          if @issue.saved_changes.include?(:status)
            @comment = @issue.comments.new(content: "•   changed status to " + @issue.status, user_id: @issue.user.id)
            @comment.save!
          end
          format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
          format.json { render :show, status: :ok, location: @issue }
        else
          format.html { render :edit }
          format.json { render json: @issue.errors, status: :unprocessable_entity }
        end
      else 
        format.json { render json: @issue.errors, status: 403}
      end
    end
  end
  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: 'Issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def delAtt
    @issue.file.destroy
    @issue.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
       params.require(:issue).permit(:title, :description, :kind, :priority, :status, :assignee_id, :file)
    end
end

