[case:[special:lang]|
  [equ:tPosts=Posts]
  [equ:tCreated=Created [PostTime]]
  [equ:tEdited=Last edited: [EditTime] by]
  [equ:tRead=read: [ReadCount] [case:[ReadCount]|times|time|times]]
  [equ:ttlQuote=Quote]
  [equ:ttlEdit=Edit]
  [equ:ttlDel=Delete]
  [equ:ttlHist=History]
|
  [equ:tPosts=Постове]
  [equ:tCreated=Създадено на [PostTime]]
  [equ:tEdited=Последно редактирано на [EditTime] от]
  [equ:tRead=видяно: [ReadCount] пъти.]
  [equ:ttlQuote=Цитирай]
  [equ:ttlEdit=Редактирай]
  [equ:ttlDel=Изтрий]
  [equ:ttlHist=История]
|
  [equ:tPosts=Посты]
  [equ:tCreated=Создано [PostTime]]
  [equ:tEdited=Отредактировано [EditTime], участником]
  [equ:tRead=прочитано [ReadCount] раз]
  [equ:ttlQuote=Цитировать]
  [equ:ttlEdit=Редактировать]
  [equ:ttlDel=Удалить]
  [equ:ttlHist=История]
|
  [equ:tPosts=Messages]
  [equ:tCreated=Crée le: [PostTime]]
  [equ:tEdited=Édité le: [EditTime] by]
  [equ:tRead=lu: [ReadCount] fois]
  [equ:ttlQuote=Citer ce message]
  [equ:ttlEdit=Éditer ce message]
  [equ:ttlDel=Supprimer ce message]
  [equ:ttlHist=Montrer l'historique du message]
|
  [equ:tPosts=Posts]
  [equ:tCreated=Erstellt am [PostTime]]
  [equ:tEdited=Zuletzt geändert: [EditTime] von]
  [equ:tRead=gelesen: [ReadCount]-mal]
  [equ:ttlQuote=Diesen Beitrag zitieren]
  [equ:ttlEdit=Diesen Beitrag ändern]
  [equ:ttlDel=Diesen Beitrag löschen]
  [equ:ttlHist=Beitragsverlauf anzeigen]
]

<div id="[id]" align=justify author="[html:[UserName]]">
  <hr size=1>
  <header [case:[Unread]||class="unread"]>
    <span style="position: relative"><img width=40 height=40 border=0 align=middle hspace=0 vspace=0 src="/!avatar/[url:[html:[UserName]]]?v=[AVer]">[case:[Unread]||<svg class="unread" width="16" height="16" viewBox="0 0 32 32" fill="#d92626">
      <path d="m12.2 12.4 3.78-11.6 3.78 11.6 12.2 4e-4-9.89 7.19 3.78 11.6-9.89-7.18-9.89 7.19 3.78-11.6-9.89-7.19z"/>
    </svg>]</span>&nbsp;
    [case:[UserID]|<span>|<a href="/!userinfo/[url:[html:[UserName]]]">]<strong>[usr:[UserName]]</strong>[case:[UserID]|</span>|</a>]

    &nbsp;<small>[case:[editUserID]|[const:tCreated]|[const:tEdited] <a href="/!userinfo/[url:[html:[EditUser]]]">[usr:[html:[EditUser]]]</a>], [const:tRead] <a href="#[id]">#[id]</a></small>
  </header>

  <section>
    [html:[[case:[format]|minimag:[include:minimag_suffix.tpl]|bbcode:][Content]]]
  </section>
  <section>
    <small>[attachments:[id]]</small>
  </section>
  <br clear=all>
  <footer>
    <a href="[case:[special:userid]|/!login|[id]/!quote]"><button type=button>[const:ttlQuote]</button></a>
    [case:[special:canedit]||&nbsp;&nbsp;<a title="" href="[id]/!edit"><button type=button>[const:ttlEdit]</button></a>]
    [case:[special:candel] ||&nbsp;&nbsp;<a title="" href="[id]/!del"><button type=button>[const:ttlDel]</button></a>]
    [case:[HistoryFlag]||[case:[special:isadmin]||&nbsp;&nbsp;<a href="/[id]/!history"><button type=button>[const:ttlHist]</button></a>]]
  </footer>
</div>

