class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :statement]

  # GET /accounts/1 or /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # POST /accounts or /accounts.json
  def create
    @account = Account.new(user: current_user)

    respond_to do |format|
      if @account.save
        format.html { redirect_to user_account_path(current_user, @account), notice: "Account was successfully created." }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end


  def deposit
  end

  def withdraw
  end

  def transfer
  end

  def statement
    @transaction = @account.transactions

    if params[:start_date].present? and params[:start_date].present?
        @transaction  = @transaction.select{ |transactions| @account.transactions.created_at.between? start_date.to_time, end_date.to_time }
    end
  end

  def close_account
    current_user.account.close
    respond_to do |format|
      format.html { redirect_to user_account_path(current_user, current_user.account), notice: "Account was successfully closed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id] || params[:account_id])
    end
end
