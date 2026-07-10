[case:[special:lang]|
  [equ:altNew=New]
  [equ:ttlThreads=Threads]
  [equ:ttlPosts=Posts]
  [equ:ttlUnread=Unread]
|
  [equ:altNew=Нови]
  [equ:ttlThreads=Теми]
  [equ:ttlPosts=Мнения]
  [equ:ttlUnread=Нови]
|
  [equ:altNew=Новые]
  [equ:ttlThreads=Темы]
  [equ:ttlPosts=Мнения]
  [equ:ttlUnread=Новые]
|
  [equ:altNew=Nouveau]
  [equ:ttlThreads=Sujets]
  [equ:ttlPosts=Messages]
  [equ:ttlUnread=Non-lus]
|
  [equ:altNew=Neu]
  [equ:ttlThreads=Themen]
  [equ:ttlPosts=Beiträge]
  [equ:ttlUnread=Ungelesen]
]

  <hr size=1>
  <h4>
  [case:[Unread]|
    <svg width="16" height="16" viewBox="0 0 32 32">
      <path d="m29 2.5e-7h-9c-1.7 0-4 .96-5.1 2.1l-14 14c-1.2 1.2-1.2 3.1 0
      4.3l11 11c1.2 1.2 3.1 1.2 4.3 0l14-14c1.2-1.2 2.1-3.5 2.1-5.1v-9c-6e-5-1.7-1.4-3-3-3zm-4
      10c-1.7 0-3-1.3-3-3s1.3-3 3-3c1.7 0 3 1.3 3 3s-1.3 3-3 3z"/>
    </svg>&nbsp;
|
  <svg width="16" height="16" fill="#d92626" viewBox="0 0 32 32">
    <path d="m 12.24,13.2 3.8,-11.6 3.76,11.6 12.2,0 -9.89,7.19 3.78,11.6 -9.89,-7.18 -9.89,7.19 3.78,-11.6 -9.89,-7.19z"/>
  </svg>&nbsp;]<a href="/[Tag]/">[Description] <small>(#[Tag])</small></a></h3>
  <p>[const:ttlThreads]: [ThreadCnt] ^| [const:ttlPosts]: [PostCnt][case:[special:userid]|| ^| [const:ttlUnread]: [unread]]
</div>
