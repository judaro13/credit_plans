class CreditPlansController < ApplicationController
  before_filter :set_account, only: [:index, :show]
  before_filter :set_public_account, only: [:new, :create, :status]
  layout 'application_plans', only: [:new, :status]
  
  def index
    @credit_plans = @account.credit_plans.order(created_at: :desc).paginate(:page => params[:page], :per_page => 50)
  end
  
  def show
    unless @credit_plan = @account.credit_plans.where(id: params[:id]).first
      redirect_to credit_plans_path(@account), alert: 'Plan de credito no encontrado'
    end
  end
  
  def new
    @credit_plan = @account.credit_plans.new
    @credit_lines = @account.credit_lines
  end
  
  def create
    @credit_plan = @account.credit_plans.new(credit_plan_params)
    if @credit_plan.save
      redirect_to check_credit_plan_path(@account, @credit_plan), notice: "Su plan fue creado con éxito"
    else
      redirect_to new_credit_plan_path(@account, @credit_plan), alert: @credit_plan.errors.full_messages.to_sentence
    end
  end
  
  def status
    @credit_plan = @account.credit_plans.where(id: params[:id]).first
  end
  
  def credit_plan_params
    params.require(:credit_plan).permit(:document, :birth_date, :amount, :months, :credit_line_id )
  end
end
