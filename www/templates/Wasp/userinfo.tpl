[css:login.css]
[css:userinfo.css]
[css:markdown.css]
[css:settings.css]

[case:[special:lang]|
  [equ:ttlIgnore=Ignore options]
  [equ:lblIgnore=Ignore]
  [equ:lblUnignore=Unignore]
  [equ:msgIgnored=You are ignoring this user.]
|
  [equ:ttlIgnore=Опции за игнориране]
  [equ:lblIgnore=Игнорирай]
  [equ:lblUnignore=Разигнорирай]
  [equ:msgIgnored=Вие игнорирате този потребител.]
|
  [equ:ttlIgnore=Опции игнорирования]
  [equ:lblIgnore=Игнорировать]
  [equ:lblUnignore=Разигнорировать]
  [equ:msgIgnored=Вы игнорируете этого пользователя.]
|
  [equ:ttlIgnore=Оptions d'ignorance]
  [equ:lblIgnore=Ignorer]
  [equ:lblUnignore=Désignore]
  [equ:msgIgnored=Vous ignorez cet utilisateur.]
|
  [equ:ttlIgnore=Ignorieroptionen]
  [equ:lblIgnore=Ignorieren]
  [equ:lblUnignore=Ignorieren aufheben]
  [equ:msgIgnored=Sie ignorieren diesen Benutzer.]
]

  <div class="user_desc post-text">
[case:[special:userid]||
 [case:[ItIsMe]|
  <div class="jsonly ignore-panel">
    <h5>[const:ttlIgnore]</h5>
    <div class="navigation3">
   [case:[special:?ignored=[userid]]|
     <p><button type=button class="btn" onclick="Ignore('[url:[UserName]]')">[const:lblIgnore]</button>
   |
     <p class="warning">[const:msgIgnored]
     <p><button type=button class="btn" onclick="Unignore('[url:[UserName]]')">[const:lblUnignore]</button>
   ]
  </div></div>|]

<script>
  function Ignore(user) {
    var http = new XMLHttpRequest();

    http.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        window.location.reload();
      }
    }

    http.open("POST", "/!ignore", true);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

    var p = "user=" + user;
    http.send(p);
  }

  function Unignore(user) {
    var http = new XMLHttpRequest();

    http.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        window.location.reload();
      }
    }

    http.open("POST", "/!unignore", true);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

    var p = "user=" + user;
    http.send(p);
  }
</script>

]
<br>


    <img class="profile_avatar" src="/!avatar/[url:[html:[UserName]]]?v=[AVer]" alt="(ツ)">
    <h1>[usr:[UserName]]</h1>
    [html:[minimag:[user_desc]]]
  </div>
  <div class="user_stat">
[case:[special:lang]|
    <h1>Statistics for [usr:[UserName]]:</h1>
    <ul>
      <li>Last seen on <b>[LastSeen]</b>
      <br>
      [case:[user_perm31]||<li>Is <b>administrator</b>]
      <li>Can [case:[user_perm0]|<b>not</b> |]<b>login</b>
      <li>Can [case:[user_perm1]|<b>not</b> |]<b>read</b> posts
      <li>Can [case:[user_perm9]|<b>not</b> |]<b>download</b> attached files

      <li>Can [case:[user_perm2]|<b>not</b> |]<b>answer</b> in threads
      <li>Can [case:[user_perm3]|<b>not</b> |]<b>start</b> new threads
      <li>Can [case:[user_perm10]|<b>not</b> |]<b>attach</b> files
      <li>Can [case:[user_perm4]|<b>not</b> |]<b>edit</b> his own posts
      <li>Can [case:[user_perm6]|<b>not</b> |]<b>delete</b> his own posts

      <li>Can [case:[user_perm5]|<b>not</b> |]<b>edit</b> others posts
      <li>Can [case:[user_perm7]|<b>not</b> |]<b>delete</b> others posts
      <li>Can [case:[user_perm8]|<b>not</b> |]<b>chat</b>
      <li>Can [case:[user_perm11]|<b>not</b> |]<b>vote</b>
      <br>
      <li>Has written [case:[totalposts]||<a href="/!search/?u=[url:[html:[UserName]]]" >]<b>[totalposts]</b> post[case:[totalposts]|s||s][case:[totalposts]||</a>] on the forum.
    </ul>
|
    <h1>Данни за [usr:[UserName]]:</h1>
    <ul>
      <li>Последно е видян на <b>[LastSeen]</b>
      <br>
      [case:[user_perm31]||<li>Е <b>администратор</b>]
      <li><b>[case:[user_perm0]|Не може|Може]</b> да <b>се включва</b>
      <li><b>[case:[user_perm1]|Не може|Може]</b> да <b>чете</b> форума
      <li><b>[case:[user_perm9]|Не може|Може]</b> да <b>сваля</b> прикачени файлове

      <li><b>[case:[user_perm2]|Не може|Може]</b> да <b>отговаря</b> в темите
      <li><b>[case:[user_perm3]|Не може|Може]</b> да <b>започва</b> нови теми
      <li><b>[case:[user_perm10]|Не може|Може]</b> да <b>прикача</b> файлове
      <li><b>[case:[user_perm4]|Не може|Може]</b> да <b>редактира</b> собствените си мнения
      <li><b>[case:[user_perm6]|Не може|Може]</b> да <b>изтрива</b> собствените си мнения

      <li><b>[case:[user_perm5]|Не може|Може]</b> да <b>редактира</b> мненията на другите
      <li><b>[case:[user_perm7]|Не може|Може]</b> да <b>изтрива</b> мненията на другите
      <li><b>[case:[user_perm8]|Не може|Може]</b> да <b>използва чата</b>
      <li><b>[case:[user_perm11]|Не може|Може]</b> да <b>гласува</b>
      <br>
      <li>Е написал [case:[totalposts]||<a href="/!search/?u=[url:[html:[UserName]]]" >]<b>[totalposts]</b> мнени[case:[totalposts]|я|е</a>|я</a>] във форума.
    </ul>
|
    <h1>Статистика для [usr:[UserName]]:</h1>
    <ul>
      <li>Последний раз входил <b>[LastSeen]</b>
      <br>
      [case:[user_perm31]||<li>Является <b>администратором</b>]
      <li><b>[case:[user_perm0]|Не может|Может]</b> <b>входит</b>
      <li><b>[case:[user_perm1]|Не может|Может]</b> <b>читать</b> форум
      <li><b>[case:[user_perm9]|Не может|Может]</b> <b>скачивать</b> прикрепленные файлы

      <li><b>[case:[user_perm2]|Не может|Может]</b> <b>отвечать</b> в темах
      <li><b>[case:[user_perm3]|Не может|Может]</b> <b>создавать</b> новые темы
      <li><b>[case:[user_perm10]|Не может|Может]</b> <b>прикреплять</b> файлы
      <li><b>[case:[user_perm4]|Не может|Может]</b> <b>редактировать</b> свои мнения
      <li><b>[case:[user_perm6]|Не может|Может]</b> <b>удалять</b> свои мнения

      <li><b>[case:[user_perm5]|Не может|Может]</b> <b>редактировать</b> чужие мнения
      <li><b>[case:[user_perm7]|Не может|Может]</b> <b>удалять</b> чужие мнения
      <li><b>[case:[user_perm8]|Не может|Может]</b> <b>входит в чат</b>
      <li><b>[case:[user_perm11]|Не может|Может]</b> <b>голосовать</b>
      <br>
      <li>Написал [case:[totalposts]||<a href="/!search/?u=[url:[html:[UserName]]]" >]<b>[totalposts]</b> мнени[case:[totalposts]|я|е</a>|я</a>] на форуме.
    </ul>
|
    <h1>Statistiques de [usr:[UserName]]:</h1>
    <ul>
      <li>Dernière connexion le <b>[LastSeen]</b>
      <br>
      [case:[user_perm31]||<li>Est <b>administrateur</b>]
      <li>[case:[user_perm0]|<b>Ne</b> peut <b>pas</b>|Peut] <b>se connecter</b>
      <li>[case:[user_perm1]|<b>Ne</b> peut <b>pas</b>|Peut] <b>lire</b> les messages
      <li>[case:[user_perm9]|<b>Ne</b> peut <b>pas</b>|Peut] <b>télécharger</b> des pièces jointes

      <li>[case:[user_perm2]|<b>Ne</b> peut <b>pas</b>|Peut] <b>répondre</b> dans un sujet
      <li>[case:[user_perm3]|<b>Ne</b> peut <b>pas</b>|Peut] <b>poster</b> un nouveau sujet
      <li>[case:[user_perm10]|<b>Ne</b> peut <b>pas</b>|Peut] <b>attacher</b> des pièces jointes
      <li>[case:[user_perm4]|<b>Ne</b> peut <b>pas</b>|Peut] <b>éditer</b> ses propres messages
      <li>[case:[user_perm6]|<b>Ne</b> peut <b>pas</b>|Peut] <b>supprimer</b> ses propres messages

      <li>[case:[user_perm5]|<b>Ne</b> peut <b>pas</b>|Peut] <b>éditer</b> d'autres messages
      <li>[case:[user_perm7]|<b>Ne</b> peut <b>pas</b>|Peut] <b>supprimer</b> d'autres messages
      <li>[case:[user_perm8]|<b>Ne</b> peut <b>pas</b>|Peut] <b>tchatter</b>
      <li>[case:[user_perm11]|<b>Ne</b> peut <b>pas</b>|Peut] <b>voter</b>
      <br>
      <li>A écrit [case:[totalposts]||<a href="/!search/?u=[url:[html:[UserName]]]" >]<b>[totalposts]</b> message[case:[totalposts]|s||s][case:[totalposts]||</a>] sur le forum.
    </ul>
|
    <h1>Statistiken für [usr:[UserName]]:</h1>
    <ul>
      <li>Zuletzt gesehen am <b>[LastSeen]</b>
      <br>
      [case:[user_perm31]||<li>Ist ein <b>Administrator</b>]
      <li>Kann <b>sich [case:[user_perm0]|<b>nicht</b> |]anmelden</b>
      <li>Kann [case:[user_perm1]|<b>nicht</b> |]Beiträge <b>lesen</b>
      <li>Kann [case:[user_perm9]|<b>nicht</b> |]angehängte Dateien <b>herunterladen</b>

      <li>Kann [case:[user_perm2]|<b>nicht</b> |]auf Themen <b>antworten</b>
      <li>Kann [case:[user_perm3]|<b>nicht</b> |]neue Themen <b>eröffnen</b>
      <li>Kann [case:[user_perm10]|<b>nicht</b> |]Dateien <b>anhängen</b>
      <li>Kann [case:[user_perm4]|<b>nicht</b> |]seine eigenen Beiträge <b>ändern</b>
      <li>Kann [case:[user_perm6]|<b>nicht</b> |]seine eigenen Beiträge <b>löschen</b>

      <li>Kann [case:[user_perm5]|<b>nicht</b> |]fremde Beiträge <b>ändern</b>
      <li>Kann [case:[user_perm7]|<b>nicht</b> |]fremde Beiträge <b>löschen</b>
      <li>Kann [case:[user_perm8]|<b>nicht</b> |]<b>chatten</b>
      <li>Kann [case:[user_perm11]|<b>nicht</b> |]<b>abstimmen</b>
      <br>
      <li>Hat [case:[totalposts]||<a href="/!search/?u=[url:[html:[UserName]]]" >]<b>[totalposts]</b> Beitr[case:[totalposts]|äge|ag|äge][case:[totalposts]||</a>] im Forum verfasst.
    </ul>
]
  </div>
