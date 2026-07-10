[case:[special:lang]|
  [equ:tThread=Thread]
  [equ:tMore=read more...]
  [equ:ttlUnread=Unread]
|
  [equ:tThread=Тема]
  [equ:tMore=повече...]
  [equ:ttlUnread=Непрочетено]
|
  [equ:tThread=Тема]
  [equ:tMore=больше...]
  [equ:ttlUnread=Нечитанное]
|
  [equ:tThread=Sujet]
  [equ:tMore=lire la suite...]
  [equ:ttlUnread=Non-lus]
|
  [equ:tThread=Thema]
  [equ:tMore=weiterlesen...]
  [equ:ttlUnread=Ungelesen]
]


<hr size=1>
<p><a href="../[rowid]/!by_id"  [case:[Unread]||title="[const:ttlUnread]"]>
      [case:[Unread]||<svg width="16" height="16" viewBox="0 0 32 32">
        <path d="m12.2 12.4 3.78-11.6 3.78 11.6 12.2 4e-4-9.89 7.19 3.78 11.6-9.89-7.18-9.89 7.19 3.78-11.6-9.89-7.19z"/>
      </svg>]
      #[rowid]
    </a>

    <a href="/!userinfo/[url:[html:[UserName]]]">
    <img width=48 height=48 border=0 align=middle hspace=4 vspace=0 src="/!avatar/[url:[html:[UserName]]]?v=[AVer]" alt="(ツ)">
    [usr:[UserName]]</a>; [const:tThread]: <a href="../[case:[special:thread]|[Slug]/|]">[Caption]</a>; [PostTime]

    <p>[content]
    <p><a href="../[rowid]/!by_id">[const:tMore]</a>

