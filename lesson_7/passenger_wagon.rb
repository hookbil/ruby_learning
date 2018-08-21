class PassengerWagon < Wagon
  attr_reader :free_seat, :busy_seat, :seat_count
  def initialize(seat_count)
    @seat_count = seat_count
    @busy_seat = 0
    @free_seat = seat_count
    @type = 'passenger'
  end

  def buy_ticket(ticket)
    return if ticket > @free_seat
    @free_seat -=  ticket
    @busy_seat += ticket
  end
end
