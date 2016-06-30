class StationsController < ApplicationController
 def station

     @stations = Station.all

   end
end
