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
    @pledge = Pledge.where("user_id=? AND status=?", current_user.id, "pending").first
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
    )

    description = get_description(@pledge)

    charge = Stripe::Charge.create(
      customer:     customer.id,   # You should store this customer id and re-use it.
      amount:       @pledge.amount_cents,
      description:  description,
      currency:     "eur"
    )

    @pledge.status = "paid"
    @pledge.save

    begin
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to root_path
    end

  end

  private

  def get_description(pledge)
    descr = pledge.typeaction.capitalize + " for "
    project_id = pledge.project
    project = Project.find(project_id)
    descr += project.title
    descr
  end

  def empty_pledges
    puts "empty_pledges"
    @pledges = Pledge.where("user_id=? AND status=?", current_user.id, "pending")
    ap @pledges
    @pledges.destroy_all
  end
end
