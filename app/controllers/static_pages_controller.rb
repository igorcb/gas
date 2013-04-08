class StaticPagesController < ApplicationController
  def report
  	@launches = Launche.select('extract (year FROM date_launche)').uniq
  end

  def listing_launches_per_year
    @launches = Launche.total_launche_year_month(params[:id])

    respond_to do |format|
      format.html
    end  
  end

end
