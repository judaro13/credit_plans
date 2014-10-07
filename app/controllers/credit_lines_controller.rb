class CreditLinesController < ApplicationController
  before_filter :set_account
  
  def index
    @credit_lines = @account.credit_lines.paginate(:page => params[:page], :per_page => 10)
  end
  
  def show
    @credit_line = @account.credit_lines.find(params[:credit_line_id])
  end
  
  def new
    @credit_line = @account.credit_lines.new
  end
  
  def edit
    @credit_line = @account.credit_lines.find(params[:id])
  end
  
  def create
    @credit_line = @account.credit_lines.new(credit_line_params)
    if @credit_line.save
      redirect_to credit_lines_path(@account), :notice => "La linea de crédito se creo exitosamente"
    else
      redirect_to new_credit_line_path(@account), :alert => @credit_line.errors.full_messages.to_sentence
    end
  end
  
  def update
    @credit_line = @account.credit_lines.find(params[:id])
    if @credit_line.update_attributes(credit_line_params)
      redirect_to credit_lines_path(@account), :notice => "La linea de crédito se actualizo exitosamente"
    else
      redirect_to new_credit_line_path(@account), :alert => @credit_line.errors.full_messages.to_sentence
    end
  end
  
  def destroy
    @credit_line = @account.credit_lines.find(params[:id])
    if @credit_line.destroy
      redirect_to credit_lines_path(@account), :notice => "La linea de crédito se borró exitosamente"
    else
      redirect_to new_credit_line_path(@account), :alert => @credit_line.errors.full_messages.to_sentence
    end
  end
  
  private
  
  def credit_line_params
    params.require(:credit_line).permit(:name, :annual_interest)
  end
end
