class PledgesController < ApplicationController
  def create
    puts "In the create of pledges"
    ap params[:stripeToken]
    ap params[:stripeEmail]
    ap params[:name]
    ap params[:description]
    ap params[:amount]
    ap params[:typeaction]
  end
end
