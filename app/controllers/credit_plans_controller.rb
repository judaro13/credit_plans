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
  
  def test_post
    account = Account.first
    @credit_plan = CreditPlan.new
    @credit_plan.account = account
    @credit_plan.credit_line = account.credit_lines.first
    @credit_plan.months = rand(12..56)
    @credit_plan.document = rand(29682456..1120563145)
    @credit_plan.birth_date = time_rand
    @credit_plan.amount = rand(1..56)*1000000
    @credit_plan.save
  end
  
  def time_rand(from = 0.0, to = Time.now)
    Time.at(from + rand * (to.to_f - from.to_f)).to_date
  end
end
