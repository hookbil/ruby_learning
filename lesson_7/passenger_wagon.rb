class PassengerWagon < Wagon

  attr_reader :free_seat, :busy_seat, :seat_count

  def initialize(seat_count)
    @seat_count = seat_count #количество мест в вагоне
    @busy_seat = 0
    @free_seat = seat_count
    @type = 'passenger'
  end

  def buy_ticket(ticket)
    if @free_seat >= ticket
      @free_seat -=  ticket
      @busy_seat += ticket
      puts "#{ticket} мест(а) теперь ваши"
    else
      puts "В вагоне недостаточно мест для покупки"
    end
  end
end