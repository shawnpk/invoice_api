module V1
  class ContactsController < ApplicationController
    def index
      contacts = current_user.contacts.all

      render json: contacts, status: :ok
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
