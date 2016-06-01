class EventsController < ApplicationController

  #GET /events/index
  #GET /events
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  #GET /events/new
  def new
    @event = Event.new
  end

  #POST /events/create
  def create
    @event = Event.new(events_params)

    @event.save

    redirect_to :action => :index #告訴遊覽器 HTTP code: 303
  end
  #GET /events/edit/ :id
  def edit
    @event = Event.find(params[:id])
  end

  #POST /events/udpate/:id
  def update
      @event = Event.find(params[:id])

      @event.update( events_params)

      redirect_to :action => :show, :id => @event
  end

  #GET /events/destroy/:id
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to :action => :index
  end


  private
  def events_params
    params.require(:event).permit(:name, :description)
  end

end
