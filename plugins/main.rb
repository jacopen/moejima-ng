# -*-ruby-*-
#
#       Ma E Jima Bot
#

# bot_file_name and BotClassName must be same name
# (BotClassName.downcase == bot_file_name)

class MoEJimaBot < Nadoka::NDK_Bot


  #誰かがジョインしたとき
  def on_join prefix, ch
    if rand(10) == 1
    post("|-`) #{prefix.nick}があらわれた！")
    end
    if prefix.nick.match(/.*hisu.*/) && rand(5) == 1
    post('|-`) 偽物め')
    end
  end

  def get_alerm_string
    array = YAML.load_file('alerm.yml')
    return array[rand(array.size)]
  end

  def on_quit_from_channel ch, nick, qmsg
  end

  def get_replies
    @ids = []
    begin
      Twitter.mentions.each do |reply|
        post_replies reply
        @ids << reply.id
      end
    rescue
    end
  end

  def post_replies reply
      if reply.id.to_i > get_last_id
        post_notice(reply.text + "   from @" + reply.user.screen_name)
      end
  end

  def get_last_id
    open('last_update.txt', 'r') do |f|
      return f.gets.to_i
    end
  end

  def set_last_id id
    open('last_update.txt', 'w+') do |f|
      f.write id
    end
  end

  def post msg
    send_privmsg(@ch, msg)
  end

  def post_notice msg
    send_notice @ch, msg
  end

  def set_flag(mode)
    @mode = mode
  end

  def check_nicovideo(number)
    doc = ''
    open('http://ext.nicovideo.jp/api/getthumbinfo/' + number) do |f|
        doc = REXML::Document.new f.read
    end

    post_notice doc.elements['/nicovideo_thumb_response/thumb/title'].text
  end
end
