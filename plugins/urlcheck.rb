class MoejimaURLCheckEvent
  def check_nicovideo(number)
    doc = ''
    open('http://ext.nicovideo.jp/api/getthumbinfo/' + number) do |f|
        doc = REXML::Document.new f.read
    end

    post_notice doc.elements['/nicovideo_thumb_response/thumb/title'].text
  end
end
