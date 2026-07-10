[case:[special:lang]|
  [equ:btnForum=Forum]
  [equ:phNick=Nickname]
  [equ:phText=Type here. Ctrl+Enter sends the message.]
  [equ:noscript=Chat requires JS because of its nature. Use the forum messages instead.]
  [equ:ttlMsg=Messages]
  [equ:ttlUsers=Users]
|
  [equ:btnForum=Форум]
  [equ:phNick=Ник]
  [equ:phText=Пиши тук.  Ctrl+Enter изпраща съобщението.]
  [equ:noscript=Чата изисква JS поради самата си същност. Вместо него, използвайте форума.]
  [equ:ttlMsg=Съобщения]
  [equ:ttlUsers=Потребители]
|
  [equ:btnForum=Форум]
  [equ:phNick=Ник]
  [equ:phText=Напиши здесь. Ctrl+Enter отправляет сообщение.]
  [equ:noscript=Чат требует JS из за своей сущности. Вместо него используйте сообщения форума.]
  [equ:ttlMsg=Сообщения]
  [equ:ttlUsers=Пользователи]
|
  [equ:btnForum=Forum]
  [equ:phNick=Nom d'utilisateur]
  [equ:phText=Taper ici. Ctrl+Enter envoie le message.]
  [equ:noscript=Le chat demande JS en raison de sa nature. Utilisez plutôt les messages du forum.]
  [equ:ttlMsg=Messages]
  [equ:ttlUsers=Users]
|
  [equ:btnForum=Forum]
  [equ:phNick=Nom d'utilisateur]
  [equ:phText=Tippen Sie hier. Mit Strg+Enter wird die Nachricht gesendet.]
  [equ:noscript=Chat erfordert aufgrund seiner Beschaffenheit JS. Verwenden Sie stattdessen die Forumsbeiträge.]
  [equ:ttlMsg=Messages]
  [equ:ttlUsers=Users]
]

<style>
  #chatlog {
    overflow-y: auto;
    height: 40vh;
    resize: vertical;
  }

  body > header, #tags-table, body > footer, body > hr, #mainmenu,#credits { display: none}
  #syslog p {display: inline; margin: 0 4px}

  .gray_user {color: gray}
  .fake_user {background-color: yellow}
</style>

<noscript>
  <h1>[const:noscript]</h1>
</noscript>

<p><a href="/"><button type="button">[const:btnForum]</button></a>

  <fieldset id="syslog">
    <legend>[const:ttlUsers]</legend>
  </fieldset>
  <fieldset id="chatlog">
    <legend>[const:ttlMsg]</legend>
  </fieldset>

  <p><a href="/"><button type="button">[const:btnForum]</button></a>

  <p><label>[const:phNick]:<br><input type="text" placeholder="[const:phNick]" id="chat_user" onkeypress="KeyPress(event, UserRename)" onChange="UserRename()">

  <p><textarea rows="4" cols="20" style="width: stretch; width: -moz-available; width: -webkit-fill-available;" placeholder="[const:phText]" id="chat_message" autofocus onkeypress="KeyPress(event, SendMessage)"></textarea>
  <button type="button" onclick="SendMessage()">Send</button>

<script src="[special:skin]/chat.js"></script>

