class EntriesController < ApplicationController

  before_action :authenticate_user!
  before_action :verify_user, only: [:show, :edit, :update, :destroy]
  before_action :check_last_entry, only: [:new]

  def index
    @entries = current_user.entries.current_month
  end

  def show
    @related_entries = current_user.entries.limit(3)
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.user = current_user
    @entry.date = Time.now.beginning_of_day
    if @entry.save
      flash[:success] = "Created post"
      redirect_to @entry
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @entry.update_attributes(entry_params)
      flash[:success] = "Your changes were saved"
      redirect_to @entry
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
    def entry_params
      params.require(:entry).permit(:title, :content)
    end

    def check_last_entry
      if current_user.entries.any? && current_user.entries.last.date == Time.now.beginning_of_day
        flash[:notice] = "Already created today, edit your last entry"
        redirect_to current_user.entries.last
      end
    end

    def verify_user
      @entry = Entry.find(params[:id])
      unless @entry.user == current_user
        flash[:danger] = "Please log in"
        redirect_to root_path
      end
    end
end
