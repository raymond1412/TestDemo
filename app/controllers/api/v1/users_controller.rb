module Api::V1
    class UsersController < ApplicationController
      def index
        @users = User.all
        render json: { status: 'SUCCESS', message: 'Loaded Users', data: @users }, status: :ok
        #render json: @users
      end

      def show
        @user = User.find(params[:id])
        render json: { status: 'SUCCESS', message: 'Loaded User', data: @user }, status: :ok
        #render json: @user
      end

      def create
        @user = User.create(user_params)

        if @user.save
          render json: { status: 'SUCCESS', message: 'Saved User', data: @user }, status: :ok
        else
          render json: { status: 'ERROR', message: 'User not saved', data: @user.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @user = User.find(params[:id])
        @user.destroy
        render json: { status: 'SUCCESS', message: 'User Deleted', data: @user }, status: :ok
      end

      def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
          render json: { status: 'SUCCESS', message: 'User Updated', data: @user }, status: :ok
        else
          render json: { status: 'ERROR', message: 'User not updated', data: @user.errors }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email)
      end
    end
  end

