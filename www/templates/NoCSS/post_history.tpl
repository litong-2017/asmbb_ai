[case:[special:lang]|
  [equ:tCreated=Created: [PostTime] by]
  [equ:tEdited=Еdited: [EditTime] by]
  [equ:ttlRestore=Restore the message to this version.]
|
  [equ:tCreated=Създадено на [PostTime] от]
  [equ:tEdited=Редактирано на [EditTime] от]
  [equ:ttlRestore=Възстанови съобщението до тази версия.]
|
  [equ:tCreated=Создано [PostTime], участником]
  [equ:tEdited=Отредактировано [EditTime], участником]
  [equ:ttlRestore=Восстановить сообщение до этой версии.]
|
  [equ:tCreated=Crée le: [PostTime] par]
  [equ:tEdited=Édité le: [EditTime] par]
  [equ:ttlRestore=Restaurer le post sur ce contenu.]
|
  [equ:tCreated=Erstellt: [PostTime] von]
  [equ:tEdited=Geändert: [EditTime] von]
  [equ:ttlRestore=Beitrag auf diese Version zurücksetzen.]
]

[case:[editUserID]|
  [equ:ttlUser=[html:[PostUser]]]
  [equ:averUser=[AVerP]]
|
  [equ:ttlUser=[html:[EditUser]]]
  [equ:averUser=[AVerE]]
]


<hr size=1>
<div id="[case:[rowid]|current|[rowid]]" align=justify>
  <header>
    [case:[rowid]|<a href="#current">#current</a>|<a href="#[rowid]">#[rowid]</a>]

    <a href="/!userinfo/[url:[const:ttlUser]]"><img width=48 height=48 border=0 align=middle hspace=4 vspace=0 src="/!avatar/[url:[const:ttlUser]]?v=[const:averUser]">&nbsp;[usr:[const:ttlUser]]</a>
    [case:[editUserID]|[const:tCreated]|[const:tEdited]] <a href="/!userinfo/[url:[const:ttlUser]]">[usr:[const:ttlUser]]</a>
    [case:[rowid]||<a title="[const:ttlRestore]" href="/[rowid]/!restore"><button type="button"><b>[const:ttlRestore]</b></button></a>]
  </header>
  
  <section>
    [html:[[case:[format]|minimag:[include:minimag_suffix.tpl]|bbcode:][Content]]]
  </section>
</div>
