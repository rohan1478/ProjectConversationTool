class ProjectsController < ApplicationController
    before_action :set_project, only: [ :show, :edit, :update, :destroy ]

    def index
      @projects = Project.all
      if params[:status].present?
        @projects = @projects.where(status: params[:status])
      end
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(project_params)
      if @project.save
        redirect_to @project, notice: "Project was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      current_status = @project.status

      if @project.update(project_params)
        record_update_status(current_status)
        redirect_to @project, notice: "Project was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @project&.destroy
      redirect_to projects_path, notice: "Project was successfully deleted."
    end

    private

    def record_update_status(current_status)
      return if @project.status == current_status

      @project.project_events.create!(old_status: current_status, new_status: project_params[:status], event_type: "status_change", user_id: current_user.id)
    end

    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(
        :title,
        :description,
        :status,
        project_events_attributes: [ :content, :event_type, :user_id ]
      )
    end
end
