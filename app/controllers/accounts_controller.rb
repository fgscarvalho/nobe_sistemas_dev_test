class AccountsController < ApplicationController
  before_action :set_account, only: :show

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end
end
