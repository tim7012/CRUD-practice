json.data do
   json.array! @events, :partial => "event", :as => :event
 end