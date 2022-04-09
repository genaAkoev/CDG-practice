class ReportsController < ApplicationController
    before_action :set_report, only: %i[update show destroy edit]

    def index
        @reports = Report.all
    end

    def create
        @report = Report.create(report_params)
        redirect_to reports_path
    end

    def update
        @report.update(report_params)
        redirect_to reports_path
    end

    def destroy
        @report.destroy
    end

    def show
    end

    def new
        @report = Report.new
    end

    def edit
    end

    private
    def report_params
        params.require(:report).permit(:user_id, :title, :description, :grade)
    end

    def set_report
        @report = Report.find(params[:id])
    end
end
