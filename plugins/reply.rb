class MoejimaReplyEvent
  def set_tasks
    @tasks = {
      ".*もえじま.*なると.*" => "send_privmsg(@ch, '|-`)つ＠');change_mode(@ch, '+o', @prefix.nick)",
      ".*もえじまー.*" => "send_privmsg(@ch, '|-`) なんだい')",
      ".*もえじまきたー.*" => "send_privmsg(@ch, '|-`) キタヨー')",
      "^(やらないか)|(もえじま.*やらないか)" => "send_privmsg(@ch, 'アッー！')",
      ".*もえじま.*(ついったー|twitter)\s(.*)" => "Twitter.update('|-`) ' + $2);post('ついったった。[|-`) ' + $2.toutf8 + ']')",
      ".*まえじま.*" => "send_privmsg(@ch, '|-`) 呼んだ？') if rand(20) == 1",
      ".*前島.*" => "send_privmsg(@ch, '|-`) 呼んだ？')if rand(20) == 1",
      ".*もえじま.*バージョン.*" => "send_privmsg(@ch, 'MoEJima Bot version 0.21 Nov 13,2009')",
      ".*もえじま.*時間.*" => "send_privmsg(@ch, Time.now.to_s)",
      ".*もえじま.*時刻合わせ.*" => "`ntpdate ntp.nict.jp`;post('|-`) なおした')",
      "^(?=.*やぎ)(?=.*この時間).{6,}$" => "post('|-`) クビか･･･')",
      ".*もえじま.*コマンド" => "@tasks.each do |key, value| post_notice(key) end",
      "^もえじま.*だまれ$" => "set_flag 'silent'",
      "^もえじま.*ほどほどに$" => "set_flag 'medium'",
      "^もえじま.*しゃべれ$" => "set_flag 'loud'",
      "^もえじま.*モード$" => "post @mode",
      ".*ぬるぽ.*" => "post('ガッ')",
      ".*やぎぽ.*" => "post('ソフトバンクッ')",
      ".*たきぽ.*" => "post('アッー！')",
      "もえじまは(何でも|なんでも)知ってるな" => "post('|-`) 何でもは知らないわ。知ってることだけ。')",
      ".*わざとだ" => "post('噛みまみた！')",
      ".*(バリバリ|ばりばり).*" => "post('やめて！')",
      "http://www.nicovideo.jp/watch/(.{2,11})" => "check_nicovideo($1)",
      "ぷおー" => "post('|-`) ぷおー')",
      "こぽー" => "post('|-`) こぽー')",
      ".*アステルバーム.*" => "post('|-`) もしかして：アスパルテーム')",
      "もえじま、ブックマーク登録(.*)" => "write_bookmark($1)",
      "ビリビリ.*" => "post('|-`) ジャッジメントですの')",
      "もえじま、ブックマーク一覧" => "show_bookmark",
      "やぎぽぷら.*" => "post('ちっちゃくないもん！')",
      "たきぽぷら.*" => "post('ちっちゃくや ら な い か ')",
      "ゆのっちー" => "post('X | _ | X ＜ お前がそう思うんならそうなんだろう　お前ん中ではな')",
      ".*かじぽ.*" => "post('|-`) でもなー･･･')",
      "ちんぽっぽ" => "post('ぼいんっ')",
      "そんな装備で大丈夫か？" => "post('|-`) 大丈夫だ、問題無い')",
      "横浜弱い" => "post('|-`) ・・・')",
      "もえじま、色つき" => "post('\0x0303 test'.tojis)",
      ".*うー.*にゃー.*" => "post('Let’s＼(・ω・)／にゃー！')"
 }
  end

  # 発言があったときイベント
  def on_privmsg prefix, ch, msg
    @mode = 'loud' if !@mode
    set_tasks
    @prefix, @ch, @msg = prefix, ch, msg.toutf8
    #tasks実行
    @tasks.each do |key, value|
      if Regexp.new(key) =~ @msg
        eval(value)
      end
    end
    #対前島汎用兵器
    if /.*hisu.*/ =~ prefix.nick
      if /.*なるとくれ.*/ =~ @msg
        send_privmsg(@ch, '|-`)・・・')
        sleep 2
        change_mode(@ch, '-o', @prefix.nick)
      end
    end
  end
end
