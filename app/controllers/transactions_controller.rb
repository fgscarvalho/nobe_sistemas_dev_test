class TransactionsController < ApplicationController
    #in routes use: get '/transactions/deposit', to: 'transactions#show_deposit'
    def create_deposit
        puts "#"*50
        puts params[:deposit][:value].to_d.class
        puts "#"*50
        @transaction = Transaction.new(value: params[:deposit][:value].to_d, account: current_user.account)
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

    #in routes use: get '/transactions/withdraw', to: 'transactions#show_withdraw'
    def create_withdraw
    end

    #def show_transfer
    #end

  end