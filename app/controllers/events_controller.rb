class EventsController < ApplicationController

  before_action :authenticate_user!, :except => [:index]

  before_action :set_event, :only => [ :show, :edit, :update, :destroy, :dashboard]
  #GET /events/index
  #GET /events
  def index


    if params[:keyword]
      @events = Event.where( [ "name like ?", "%#{params[:keyword]}%" ] )
    else
      @events = Event.all
    end

    if params[:order]
      sort_by = (params[:order] == 'name') ? 'name' : 'id'
      @events = @events.order(sort_by)
    end
    #here needs to change for search
    @events = @events.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @events.to_xml }
      format.json { render :json => @events.to_json }
      format.atom { @feed_title = "My event list" } # index.atom.builder
    end
  end

  # GET /events/latest
  def latest
    @events = Event.order("id DESC").limit(3)
  end

  def show

    respond_to do |format|
      format.html { @page_title = @event.name } # show.html.erb
      format.xml # show.xml.builder
      format.json { render :json => { id: @event.id, name: @event.name }.to_json }
    end
  end

  #GET /events/:id/dashboard
  def dashboard

  end

  #GET /events/new
  def new
    @event = Event.new
  end

  #POST /events/create
  def create
    @event = Event.new(events_params)

    @event.user = current_user

    if @event.save
      redirect_to :action => :index
      flash[:notice] = "event was successfully created"
    else
      render :action => :new
    end
  end

  #GET /events/edit/ :id
  def edit

  end

  #POST /events/udpate/:id
  def update
    if @event.update(events_params)
      if params[:destroy_logo]
         @event.logo = nil
         @event.save
      end

      redirect_to :action => :show, :id => @event
      flash[:notice] = "event was successfully updated"
    else
      render :action => :edit
    end
  end

  #GET /events/destroy/:id
  def destroy

    @event.destroy
    redirect_to events_path :action => :index
    flash[:alert] = "event was successfully deleted"
  end

  # POST /events/bulk_delete
  def bulk_update
    ids = Array(params[:ids]) # single number or nil will still have an array
    events = ids.map{ |i| Event.find_by_id(i)}.compact #compact delete nil

    if params[:commit] == "Delete"
      events.each { |e| e.destroy}
    elsif params[:commit] == "Publish"
      events.each{ |e| e.update( :status => "published")}
    end
    redirect_to :back
  end

  private
  def events_params
    params.require(:event).permit(:name, :description, :category_id, :status, :logo, :group_ids => [] )
  end

  def set_event
    @event = Event.find(params[:id])
  end

end
