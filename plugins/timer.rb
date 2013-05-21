# encoding: utf-8

class TimerEvent
  include Cinch::Plugin

  timer 60, method: :on_timer

  def on_timer
    #daily
    #hourly
    every_minutes
  end

  def daily
    if t.hour == 0 && t.min == 0
      post Time.now.strftime("|-`) %m月%d日 %Aになりました")
    end
  end

  def hourly
    if t.min == 0
      if @mode == 'loud' || (@mode == 'medium' && rand(3) == 1)
        @state.channels.each{|ch|
          @ch = ch
          post(get_alerm_string.gsub("{t.hour}", t.hour.to_s))
        }
      end
    end
  end

  def every_minutes
    Channel("#udcp-dev2").notice "event"
  end

  def get_alerm_string
    array = YAML.load_file('alerm.yml')
    return array[rand(array.size)]
  end
end
