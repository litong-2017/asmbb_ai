[css:toaster.css]

[case:[special:lang]|
  [equ:ttlPublic=Public threads]
  [equ:ttlLimited=Limited access threads]
  [equ:btnPublic=Public]
  [equ:btnLimited=Limited]
  [equ:btnRegister=Register]
  [equ:btnLogin=Login]
  [equ:btnLogout=Logout]
  [equ:btnProfile=Profile]
  [equ:ttlSearchTxt=text search]
  [equ:ttlSearchUsr=user search]
  [equ:ttlSearchBtn=Search]
  [equ:ttlAllThreads=All tags]
  [equ:ttlTags=Tags]
  [equ:ttlNotifications=Off/On the real time notifications]
  [equ:btnCats=Categories]
  [equ:btnSettings=Settings]
  [equ:btnConsole=SQL console]
  [equ:btnChat=Chat]
  [equ:btnList=Threads]
  [equ:rssfeed=Subscribe]
|
  [equ:ttlPublic=Публични теми]
  [equ:ttlLimited=Теми с ограничен достъп]
  [equ:btnPublic=Публични]
  [equ:btnLimited=Ограничени]
  [equ:btnRegister=Регистрация]
  [equ:btnLogin=Вход]
  [equ:btnLogout=Изход]
  [equ:btnProfile=Профил]
  [equ:ttlSearchTxt=търсене на текст]
  [equ:ttlSearchUsr=потребител]
  [equ:ttlSearchBtn=Търсене]
  [equ:ttlAllThreads=Всички теми]
  [equ:ttlTags=Тагове]
  [equ:ttlNotifications=Изкл/Вкл на нотификациите в реално време]
  [equ:btnCats=Категории]
  [equ:btnSettings=Настройки]
  [equ:btnConsole=SQL конзола]
  [equ:btnChat=Чат]
  [equ:btnList=Теми]
  [equ:rssfeed=Абонирай се]
|
  [equ:ttlPublic=Публичные темы]
  [equ:ttlLimited=Темы с ограниченным доступом]
  [equ:btnPublic=Публичные]
  [equ:btnLimited=Ограниченные]
  [equ:btnRegister=Регистрация]
  [equ:btnLogin=Вход]
  [equ:btnLogout=Выйти]
  [equ:btnProfile=Профиль]
  [equ:ttlSearchTxt=поиск текста]
  [equ:ttlSearchUsr=пользователь]
  [equ:ttlSearchBtn=Поиск]
  [equ:ttlAllThreads=Все темы]
  [equ:ttlTags=Ярлыки]
  [equ:ttlNotifications=Выкл/Вкл нотификации в реальном времени]
  [equ:btnCats=Категории]
  [equ:btnSettings=Настройки]
  [equ:btnConsole=SQL конзоль]
  [equ:btnChat=Чат]
  [equ:btnList=Темы]
  [equ:rssfeed=Подпишитесь]
|
  [equ:ttlPublic=Discussions publiques]
  [equ:ttlLimited=Discussions restreintes]
  [equ:btnPublic=Publiques]
  [equ:btnLimited=Restreintes]
  [equ:btnRegister=Inscription]
  [equ:btnLogin=Connexion]
  [equ:btnLogout=Se déconnecter]
  [equ:btnProfile=Profil]
  [equ:ttlSearchTxt=recherche de texte]
  [equ:ttlSearchUsr=recherche d'utilisateur]
  [equ:ttlSearchBtn=Rechercher]
  [equ:ttlAllThreads=Montrer tous les sujets]
  [equ:ttlTags=Mots-clés]
  [equ:ttlNotifications=Off/On the real time notifications]
  [equ:btnCats=Catégories]
  [equ:btnSettings=Paramètres]
  [equ:btnConsole=Console SQL]
  [equ:btnChat=Тchat]
  [equ:btnList=Liste des sujets]
  [equ:rssfeed=Suivre]
|
  [equ:ttlPublic=Öffentliche Themen]
  [equ:ttlLimited=Themen mit beschränktem Zugang]
  [equ:btnPublic=Öffentliche]
  [equ:btnLimited=Beschränkt]
  [equ:btnRegister=Registrieren]
  [equ:btnLogin=Anmelden]
  [equ:btnLogout=Abmelden]
  [equ:btnProfile=Profil]
  [equ:ttlSearchTxt=Textsuche]
  [equ:ttlSearchUsr=Benutzersuche]
  [equ:ttlSearchBtn=Suchen]
  [equ:ttlAllThreads=Alle Themen zeigen]
  [equ:ttlTags=Tags]
  [equ:ttlNotifications=Off/On the real time notifications]
  [equ:btnCats=Kategorien]
  [equ:btnSettings=Einstellungen]
  [equ:btnConsole=SQL-Konsole]
  [equ:btnChat=Chat]
  [equ:btnList=Themen]
  [equ:rssfeed=Abonnieren]
]
<!DOCTYPE html>
<html lang="[case:[special:lang]|en|bg|ru|fr|de]" style="max-width: 60em; margin: 0 auto;">
<head>
  <meta charset="utf-8">
  <title>[special:title]</title>
  [case:[special:limited]|<link href="!feed" type="application/atom+xml" rel="alternate" title="Atom feed">|]
  <meta name="description" content="[special:description]">
  <meta name="keywords" content="[special:keywords]">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">

  [special:allstyles]

  <style>
    body {font-size: 16px}

    p, table {word-break: break-word; hyphens: auto}

    figure {
      margin: 1em auto;
      text-align: center;
    }

    iframe,fieldset{max-width: 100%}
    img{max-width:100%; max-height:30vh; image-rendering: pixelated}

    code {
      max-width: 100%;
      max-height: 20em;
    }

    textarea, input[type="text"], input[type="password"] {
      width: stretch;
      width: -moz-available;
      width: -webkit-fill-available;
    }

    blockquote {margin: 8px 0}

    legend {font-weight: bold;}

    svg.unread { position: absolute; left:40px; top:22px;}

    header.unread {
      background-color: #84fd7a;
    }
  </style>

  <noscript>
    <style> .jsonly { display: none !important } </style>
  </noscript>

  <script>
    var ActiveSkin = '[special:skin]';
    [raw:realtime.js]
  </script>

<body text=#444 link=blue vlink=blue>
  <header>
    [special:header]

    <p>
      <input form="frm_search" type="search" size="25" name="s" placeholder="[const:ttlSearchTxt]" value="[special:search]">
      <input form="frm_search" type="search" size="15" name="u" placeholder="[const:ttlSearchUsr]" value="[special:usearch]">
      <button form="frm_search" type="submit" title="[const:ttlSearchBtn]">[const:ttlSearchBtn]</button>
      ^|
      <select form="frm_skin" name="skin" onchange="this.form.submit()">
        <option value="0">(Default)</option>
        [special:skins=[special:skincookie]]
      </select>
      <noscript><input form="frm_skin" type="submit" value="Go"></noscript>
      ^|
      [case:[special:userid]
        |[case:[special:canregister]||<a href="/!register"><button type=button>[const:btnRegister]</button></a>&nbsp;]
        <a href="/!login"><button type=button>[const:btnLogin]</button></a>
        |<input form="frm_logout" name="logout" type="submit" title="[enc:[special:username]]" value="[const:btnLogout]">
        <a href="/!userinfo/[url:[special:username]]" title="[enc:[special:username]]">[const:btnProfile]</a>
      ]

    <form id="frm_search" action="[case:[special:cmdtype]||/|../]!search/" method="get" ></form>
    <form id="frm_skin" method="post" action="/!skincookie"></form>
    <form id="frm_logout" method="post" action="/!logout"></form>

      [case:[special:userid]||
        <a href="/[case:[special:dir]||[special:dir]/]" title="[const:ttlPublic]" accesskey="p">[const:btnPublic] [case:[special:unread]||([special:unread])]</a> ^|
        <a href="/(o)/[case:[special:dir]||[special:dir]/]" title="[const:ttlLimited]" accesskey="l">[const:btnLimited] [case:[special:unreadLAT]||([special:unreadLAT])]</a>]
  </header>

<hr size=1>
<table id="tags-table" cellspacing=0><tr valign=top>
<td valign=top width=32>
  <a href="/[case:[special:limited]||(o)/]" title="[const:ttlAllThreads]">
    <img align=top width=24 height=24 src="[special:skin]/_images/alltags.png">
  </a>
<td>
<details>
  <summary>[case:[special:dir]|All tags|<b>#[special:dir]</b>]</summary>
  [special:alltags]
</details>
</table>
<hr size=1>
<p id="mainmenu">
  [case:[special:thread]||
  <a href="/[case:[special:limited]||(o)/][special:dir][case:[special:dir]||/]">[const:btnList]</a> ^| ]
  <a href="/!categories">[const:btnCats]</a> ^|
  [case:[special:canchat]||<a href="/!chat" accesskey="c">[const:btnChat]</a> ^|]

  <button type="button" class="jsonly" onclick="switchNotificationCookie();" title="[const:ttlNotifications]">
    <svg width="16" height="16" viewBox="0 0 20 20">
     <circle cx="10" cy="17" r="3" />
     <path d="m20 17h-20c0-1.37 1.7-1.08 2-3 .663-4.28 1.1-11 8-11 7.12 0 7.41 6.61 8 11 .239 1.78 2 1.73 2 3z"/>
     <path d="m10 0a3 3 0 00-3 3 3 3 0 003 3 3 3 0 003-3 3 3 0 00-3-3zm0 2a1 1 0 011 1 1 1 0 01-1 1 1 1 0 01-1-1 1 1 0 011-1z"/>
     <line id="notiStroked" x1="0" y1="20" x2="20" y2="0" style="stroke-width:4;stroke:hsl(0, 70%, 50%);visibility:hidden;"/>
    </svg>
  </button>
  <span class="jsonly">^|</span>
  [case:[special:isadmin] ||
    <a href="/!settings" accesskey="s">[const:btnSettings]</a> ^|
    <a href="/!sqlite" accesskey="k">[const:btnConsole]</a> ^|
    <a href="/!debuginfo">Debug info</a> ^|]

    [case:[special:limited]|<a href="!feed" title="[const:rssfeed]"><svg version="1.1" width="12" height="12" viewBox="0 0 32 32">
        <path d="m21 32h-6c0-8.2-6.8-15-15-15v-6c11.8 0 21 9.21 21 21z"/>
        <path d="m26 32c0-14.2-11.8-26-26-26v-6c17.7 0 32 14.4 32 32z"/>
        <circle cx="4.5" cy="27.5" r="4.5"/>
      </svg></a>|]
</p>
