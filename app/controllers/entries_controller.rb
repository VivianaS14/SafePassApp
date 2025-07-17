class EntriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @entries = current_user.entries
    @main_entry = current_user.entries.first
  end

  def show
    @entry = current_user.entries.find(params[:id])
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.new(entry_params)

    if @entry.save
      # We want to see the flash in the current action, we put .now
      # otherwise it'll be render in redirect path, and using turbo stream that path never render
      flash.now[:notice] = "<strong>#{@entry.name}<strong> has saved!".html_safe
      # Tu use turbo stream we use a respond block
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream { }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def entry_params
    params.expect(entry: [ :name, :url, :username, :password ])
  end
end
