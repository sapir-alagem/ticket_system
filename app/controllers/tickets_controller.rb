class TicketsController < ApplicationController
  require 'csv'

  before_action :set_ticket, only: %i[ show edit update destroy change_status ]

  # GET /tickets or /tickets.json
  def index
    @tickets = Ticket.all
  end

  # GET /tickets/1 or /tickets/1.json
  def show
    @ticket = Ticket.includes(:user).find(params[:id])
  end

  # GET /tickets/new
  def new
    # @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets or /tickets.json
  def create
    subject = params[:subject]
    content = params[:content]
    ticket_data = [current_user.name, current_user.email, subject, content, "created"]

    csv_file = "public/tickets.csv"

    if File.exist?(csv_file)
      CSV.open(csv_file, "a+") do |csv|
        csv << ticket_data
      end
    else
      CSV.open(csv_file, "a+") do |csv|
        csv << ["Requester Name", "Requester Email", "Subject", "Content", "Status"]
        csv << ticket_data
      end
    end

    redirect_to tickets_path, notice: "Ticket was successfully added to file."
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    @ticket.destroy!

    respond_to do |format|
      format.html { redirect_to manager_portal_tickets_path, notice: "Ticket was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def manager_portal
    if current_user.manager?
      @tickets = Ticket.all
    else
      redirect_to root_path
      flash[:alert] = "You are not authorized to view requested page."
    end
  end

  def change_status
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(:subject, :content, :status, :user_id)
    end
end
