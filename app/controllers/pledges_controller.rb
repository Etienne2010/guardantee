class PledgesController < ApplicationController
  def new
    projnum = params[:projnum]
    amount_c = (params[:amount].to_f * 100.to_f).to_i
    typeaction = params[:typeaction]
    ap amount_c
    empty_pledges
    @pledge = Pledge.new(project: projnum.to_i, amount_cents: amount_c, typeaction: typeaction, status: "pending")
    @pledge.user = current_user
    if @pledge.save
      ap "Pledge pending saved"
      # formlayout = "<form action='/pledges' method='POST'>" +
      formlayout = "<script src='https://checkout.stripe.com/checkout.js' class='stripe-button' " +
          "data-key=#{Rails.configuration.stripe[:publishable_key]} " +
          "data-name='My project' " +
          "data-email='#{current_user.email}' " +
          "data-description='#{projnum}' " +
          "data-amount='#{amount_c}' " +
          "data-currency='eur'></script>"
      ap formlayout
      render html: formlayout.html_safe
    else
      ap "Bug pledge"
    end
  end

  def create
    puts "In the create of pledges"
    ap params[:stripeToken]
    ap params[:stripeEmail]
  end

  private

  def empty_pledges
    @pledges = Pledge.where("user_id=? AND status=?", current_user.id, "pending")
    @pledges.destroy_all
  end
end
