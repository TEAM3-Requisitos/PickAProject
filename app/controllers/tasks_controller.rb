class TasksController < ApplicationController
  before_action :set_task, only: [:assign_to_user, :ask_to_be_maker]
  before_action :set_requester, only: [:assign_to_user, :ask_to_be_maker]

  def assign_to_user
    
  end

  def ask_to_be_maker
    @task.<<
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @task = Task.find(params[:id])
    end

    def set_requester
      @requester = User.find(params[:requester_id])
    end
end
