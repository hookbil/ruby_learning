class Station
    attr_reader :trains, :station_name
    def initialize(station_name)
      @station_name = station_name
      @trains=[]
    end
  
    def take_train(train)
      @trains.push(train)
    end
  
    def type_of_trains(type)
      @trains.select { |train| train.type == type}
    end
  
    def send_train(train)
      @trains.delete(train)
    end
end
  
  