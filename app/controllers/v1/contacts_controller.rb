module V1
  class ContactsController < ApplicationController
    before_action :authorize

    def index
      contacts = current_user.contacts.all

      render json: contacts, include: 'user', status: :ok 
    end

    def show
      @contact = current_user.contacts.find(params[:id])
      
      render json: @contact, include: 'user', status: :ok
    end

    def create
      contact = current_user.contacts.new(contact_params)
      contact.save!

      render json: contact, status: :created
    end

    def destroy
      contact = current_user.contacts.find(params[:id])
      contact.destroy!

      head :no_content
    end

    private
      def contact_params
        params.require(:contact).permit(:first_name, :last_name, :email)
      end
  end
end
