class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry, only: %i[show edit update destroy]

  def index
    @entries = current_user.entries.search(params[:name])
    @main_entry = @entries.first

    return unless params[:name].present?
    if @entries.length == 1
      # Turbo stream response inline
      render turbo_stream: [
        turbo_stream.update("main-dashboard", partial: "entries/main", locals: { entry: @entries.first }),
        turbo_stream.update("entries-list", partial: "entries/entry", locals: {
          entry: @entries.first
        })
      ]
    end
  end

  def show
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

  def edit
  end

  def update
    if @entry.update(entry_params)
      flash.now[:notice] = "#{@entry.name} has been updated."
      respond_to do |format|
        format.html { redirect_to @entry }
        format.turbo_stream { }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @entry.destroy
    flash.now[:notice] = "#{@entry.name} has been deleted!"
    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream { }
    end
  end

  private

  def entry_params
    params.expect(entry: [ :name, :url, :username, :password ])
  end

  def set_entry
    @entry = current_user.entries.find(params[:id])
  end
end
