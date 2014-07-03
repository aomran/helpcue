class API::V1::InvitationsController < ApplicationController

  before_action :get_classroom
  after_action :verify_authorized

  def create
    authorize @classroom, :edit?
    @emails = params[:invitation_emails].split(/,|\n/).map!(&:strip)

    if @emails.any? && valid_emails?
      InvitationMailer.invite(@emails, @classroom.id).deliver
      redirect_to classroom_users_path(@classroom), notice: "Invitations sent."
    else
      redirect_to classroom_users_path(@classroom), alert: "Invalid email format"
    end
  end

  private
  def valid_emails?
    @emails.each do |email|
      return false unless /\A[^@]+@[^@]+\z/.match(email)
    end
  end
end
