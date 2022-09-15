class TransactionsController < ApplicationController
  before_action :set_destination, only: :create_transfer
  before_action :authenticate_user!, only: [:create_transfer, :create_withdraw]

  def create_deposit
      @transaction = Transaction.new(value: params[:deposit][:value].to_d, account: current_user.account, kind: :deposit)
      @transaction.deposit
      respond_to do |format|
          if @transaction.save
            format.html { redirect_to user_account_path(current_user, current_user.account), notice: "The deposit was successfully." }
            format.json { render :show, status: :created, location: @transaction }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @transaction.errors, status: :unprocessable_entity }
          end
      end
  end


  def create_withdraw
    respond_to do |format|
      if current_user.account.enough_founds? params[:withdraw][:value]
        @transaction = Transaction.new(value: params[:withdraw][:value].to_d, account: current_user.account, kind: :withdraw)
        @transaction.withdraw
            if @transaction.save
              format.html { redirect_to user_account_path(current_user, current_user.account), notice: "The withdraw was successfully." }
              format.json { render :show, status: :created, location: @transaction }
            else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @transaction.errors, status: :unprocessable_entity }
            end
      else
        format.html { redirect_to user_account_withdraw_path(current_user, current_user.account.id), notice: "The balance is not enough." }
      end
    end
  end

  def create_transfer
    respond_to do |format|
      if current_user.account.enough_founds? params[:transfer][:value]
        if current_user.account != @destination_account
          @transaction = Transaction.new(value: params[:transfer][:value].to_d, account: current_user.account, kind: :transfer)
          @transaction.transfer(@destination_account)
              if @transaction.save
                format.html { redirect_to user_account_path(current_user, current_user.account), notice: "The transfer was successfully." }
                format.json { render :show, status: :created, location: @transaction }
              else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @transaction.errors, status: :unprocessable_entity }
              end
        else
          format.html { redirect_to user_account_withdraw_path(current_user, current_user.account.id), notice: "That is your Account." }
        end
      else
        format.html { redirect_to user_account_withdraw_path(current_user, current_user.account.id), notice: "The balance is not enough." }
      end
    end
  end

  private

  def set_destination
    @destination_account = Account.find(params[:transfer][:destination_account])
  end
end
