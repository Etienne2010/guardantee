class PledgesController < ApplicationController
  def new
    projnum = params[:projnum]
    amount_c = (params[:amount].to_f * 100.to_f).to_i
    typeaction = params[:typeaction]
    ap amount_c
    ap projnum
    empty_pledges
    @pledge = Pledge.new(project: projnum.to_i, amount_cents: amount_c, typeaction: typeaction, status: "pending")
    @pledge.user = current_user
    if @pledge.save
      ap "Pledge pending saved"
      formlayout = "<h6>Success</h6>"
      # formlayout = "<form action='/pledges' method='POST'>" +
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
    puts "empty_pledges"
    @pledges = Pledge.where("user_id=? AND status=?", current_user.id, "pending")
    ap @pledges
    @pledges.destroy_all
  end
end
