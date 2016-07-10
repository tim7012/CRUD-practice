class ApiV1::EventsController < ApiController

  def show
     @event = Event.find(params[:id])

    # show.json.jbuilder
  end

    # GET /api/v1/topics
  def index
     @events = Event.page( params[:page] ).per(5)

    # index.json.jbuilder
  end

  # def create

  #  end
end
