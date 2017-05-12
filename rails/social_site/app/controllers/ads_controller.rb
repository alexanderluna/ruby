class AdsController < ApplicationController

  before_action :admin_user, only: [:show, :create, :edit, :update]

  def show
  end

  def create
    @ad = Ad.first_or_create do |advertisment|
            advertisment.big_ad = params[:big_ad]
            advertisment.banner_ad = params[:banner_ad]
          end
    if @ad.save
      flash[:success] = "The Ad was created and saved"
      redirect_to current_user
    else
      flash[:danger] = "The Ad could not be created"
      redirect_to current_user
    end
  end

  def edit
    @ad = Ad.first
  end

  def update
    @ad = Ad.first
    if @ad.update_attributes(ad_params)
      flash[:success] = "The Ad was saved"
      redirect_to current_user
    else
      flash[:danger] = "The Ad could not be saved"
    end
  end
  

  private

  def ad_params
    params.require(:ad).permit(:big_ad, :banner_ad)
  end

  def admin_user
    unless current_user.admin?
      redirect_to root_path
    end
  end
end
