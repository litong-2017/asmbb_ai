[css:highlight.css]

[case:[special:lang]|
  [equ:btnList=Threads]
  [equ:btnNewPost=Answer]
  [equ:ttlEditThread=Edit the thread attributes.]
|
  [equ:btnList=Теми]
  [equ:btnNewPost=Отговор]
  [equ:ttlEditThread=Редактиране на атрибутите на темата.]
|
  [equ:btnList=Темы]
  [equ:btnNewPost=Ответить]
  [equ:ttlEditThread=Редакция атрибутов темы]
|
  [equ:btnList=Liste des sujets]
  [equ:btnNewPost=Répondre]
  [equ:ttlEditThread=Éditer le titre du sujet et les mots-clés.]
|
  [equ:btnList=Themen]
  [equ:btnNewPost=Antworten]
  [equ:ttlEditThread=Themenoptionen ändern.]
]

[css:highlight.css]

<hr size=1>
<h2>[caption]
[case:[special:canedit]||<a href="!edit_thread" title="[const:ttlEditThread]">
  <svg width="16" height="16" viewBox="0 0 32 32" fill="#d92626">
    <path d="m19 4-14 14-5 14 14-5 14-14-9-9zm-13 16.4 5.6 5.6-5.6 2-2-2 2-5.6z"/>
    <path d="m20 3 9 9 3-3-9-9z"/>
  </svg></a>]
</h2>

<p><a href=".."><button type=button>[const:btnList]</button></a>&nbsp;&nbsp;[case:[special:userid]|<a href="/!login"><button type=button>[const:btnNewPost]</button></a>|<a href="!edit"><button type=button>[const:btnNewPost]</button></a>]

