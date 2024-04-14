class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy change_status ]
  before_action :redirect_if_not_manager, only: [:manager_portal, :edit, :change_status]

  # GET /tickets or /tickets.json
  def index
    @statistics = Ticket.statistics
    if params[:query].present?
      @tickets = Ticket.search(params[:query])
    else
      @tickets = Ticket.all
    end
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
    Ticket.add_new_ticket_to_csv(current_user, params[:subject], params[:content])
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
    @ticket.destroy

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
    @ticket = Ticket.includes(:comments).find(params[:id])
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

    def redirect_if_not_manager
      unless current_user.manager?
        redirect_to root_path
        flash[:alert] = "You are not authorized to view requested page."
      end
    end
end
