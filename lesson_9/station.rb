require_relative 'instance_counter.rb'
require_relative 'validation.rb'
require_relative 'accessors.rb'

class Station
  include InstanceCounter
  include Validation
  include Accessors
  attr_reader :trains
  attr_accessor_with_history :station_name
  strong_attr_accessor :station_type, String
  STATION_REGEXP = /^[a-zA-Z]{3}$/i

  validate :station_name, :presence
  validate :station_name, :type, String
  validate :station_name, :format, STATION_REGEXP

  @@all_stations = []
  def self.all
    @@all_stations
  end

  def initialize(station_name)
    @station_name = station_name
    @trains = []
    validate!
    @@all_stations.push(self)
    add_instance
  end

  def take_train(train)
    @trains.push(train)
  end

  def type_of_trains(type)
    @trains.select { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end

  def each_train(&_block)
    @trains.each { |train| yield(train) } unless @trains.empty?
  end
end
