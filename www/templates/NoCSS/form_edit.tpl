[css:highlight.css]

[case:[special:lang]|
  [equ:Caption=Thread title]
  [equ:Content=Post content]
  [equ:btnPreview=Preview]
  [equ:btnSubmit=Submit]
  [equ:hintPreview=Ctrl+Enter for preview]
  [equ:hintSubmit=Ctrl+S for submit]
  [equ:Attach=Attach file(s)]
  [equ:tabThread=Thread]
  [equ:tabText=Text]
  [equ:tabAttach=Attachments]
  [equ:FileLimit=(count ≤ 10, size ≤ 1MB)]
  [equ:ttlLimited=Limited access thread]
  [equ:ttlInvited=Invited users&nbsp;<small>(comma separated list)</small>]
  [equ:ttlTitle=Title]
  [equ:phTitle=Thread title]
  [equ:ttlTags=Tags:&nbsp;<small>(max 3, comma delimited, no spaces)</small>]
  [equ:phTags=some tags here]
  [equ:ttlPin=Important thread, rank]
  [equ:lblAfter=after: ]
|
  [equ:Caption=Заглавие на темата]
  [equ:Content=Съдържание на поста]
  [equ:btnPreview=Преглед]
  [equ:btnSubmit=Публикувай]
  [equ:hintPreview=Ctrl+Enter за преглед]
  [equ:hintSubmit=Ctrl+S за публикуване]
  [equ:Attach=Прикачи файл(ове)]
  [equ:tabThread=Тема]
  [equ:tabText=Текст]
  [equ:tabAttach=Файлове]
  [equ:FileLimit=(брой ≤ 10, размер ≤ 1MB)]
  [equ:ttlLimited=Тема с ограничен достъп]
  [equ:ttlInvited=Поканени в темата <small>(разделени със запетаи)</small>]
  [equ:ttlTitle=Заглавие]
  [equ:phTitle=Заглавие на темата]
  [equ:ttlTags=Тагове:&nbsp;<small>(макс. 3, разделени със запетаи, без шпации)</small>]
  [equ:phTags=някакви тагове тук]
  [equ:ttlPin=Важна тема, ранг]
  [equ:lblAfter=след: ]
|
  [equ:Caption=Название темы]
  [equ:Content=Содержание поста]
  [equ:btnPreview=Просмотр]
  [equ:btnSubmit=Отправить]
  [equ:hintPreview=Ctrl+Enter для предварительного просмотра]
  [equ:hintSubmit=Ctrl+S чтобы отправить]
  [equ:Attach=Прикрепить файл(ы)]
  [equ:tabThread=Тема]
  [equ:tabText=Текст]
  [equ:tabAttach=Вложения]
  [equ:FileLimit=(количество ≤ 10, размер ≤ 1MB)]
  [equ:ttlLimited=Тема с ограниченным доступом]
  [equ:ttlInvited=Приглашенные участники <small>(список через запятую)</small>]
  [equ:ttlTitle=Название темы]
  [equ:phTitle=Название темы]
  [equ:ttlTags=Ярлыки:&nbsp;<small>(макс. 3, через запятую, без пробелов)</small>]
  [equ:phTags=теги пишутся здесь]
  [equ:ttlPin=Важная тема, ранг]
  [equ:lblAfter=через: ]
|
  [equ:Caption=Titre du sujet]
  [equ:Content=Contenu du message]
  [equ:btnPreview=Prévisualiser]
  [equ:btnSubmit=Soumettre]
  [equ:hintPreview=Ctrl+Entrée pour prévisualiser]
  [equ:hintSubmit=Ctrl+S pour soumettre]
  [equ:Attach=Pièce(s) jointe(s)]
  [equ:tabThread=Sujet]
  [equ:tabText=Texte]
  [equ:tabAttach=Pièces jointes]
  [equ:FileLimit=(count ≤ 10, size ≤ 1MB)]
  [equ:ttlLimited=Sujet restreint]
  [equ:ttlInvited=Inviter des utilisateurs <small>(séparés par une virgule)</small>]
  [equ:ttlTitle=Titre]
  [equ:phTitle=Titre du sujet]
  [equ:ttlTags=Mots-clés:&nbsp;<small>(3 maximum, séparés par une virgule t sans espace)</small>]
  [equ:phTags=quelques mots-clés]
  [equ:ttlPin=Sujet important, classement]
  [equ:lblAfter=après: ]
|
  [equ:Caption=Titel des Themas]
  [equ:Content=Inhalt des Beitrags]
  [equ:btnPreview=Vorschau]
  [equ:btnSubmit=Absenden]
  [equ:hintPreview=Strg+Eingabe für eine Vorschau]
  [equ:hintSubmit=Strg+S zum Absenden]
  [equ:Attach=Datei(en) anhängen]
  [equ:tabThread=Thema]
  [equ:tabText=Text]
  [equ:tabAttach=Anhänge]
  [equ:FileLimit=(Anzahl ≤ 10, Größe ≤ 1MB)]
  [equ:ttlLimited=Thema mit beschränktem Zugang]
  [equ:ttlInvited=Eingeladene Mitglieder <small>(durch Kommas getrennt)</small>]
  [equ:ttlTitle=Titel]
  [equ:phTitle=Titel des Themas]
  [equ:ttlTags=Tags:&nbsp;<small>(max. 3, durch Kommas getrennt, keine Leerzeichen)</small>]
  [equ:phTags=hier einige Tags]
  [equ:ttlPin=Wichtiges Thema, Rang]
  [equ:lblAfter=nach: ]
]

<form id="editform" action="[special:cmd]" method="post" onsubmit="previewIt(event)" enctype="multipart/form-data">


  <div align=right><a id="btn-close" href="[case:[id]|[case:[special:page]|.|!by_id]|!by_id]"><svg width="24" height="24" viewBox="0 0 24 24">
      <circle cx="12" cy="12" r="12" fill="#d92626" style="paint-order:markers fill stroke"/>
      <path d="m5.5 18.5 13-13" fill="none" stroke="#fff" stroke-linecap="round" stroke-width="3"/>
      <path d="m5.5 5.5 13 13" fill="none" stroke="#fff" stroke-linecap="round" stroke-opacity=".99436" stroke-width="3"/>
    </svg></a>
  </div>


  <fieldset [case:[EditThread]|style="display:none;"|]>
    <legend>Thread properties</legend>
      <p><label for="title">[const:Caption]:</label><br><input id="title" type="text" value="[caption]" placeholder="[const:phTitle]" name="title">
      <p><label for="tags">[const:ttlTags][case:[special:dir]| |+ "[special:dir]"]</label><br><input id="tags" type="text" value="[tags]" name="tags" id="tags" placeholder="[const:phTags]" oninput="OnKeyboard(this)" onkeydown="EditKeyDown(event, this)" getlist="/!tagmatch/">
      [case:[special:isadmin]||<p><label>[const:ttlPin]:&nbsp;<input size=6 type="number" value="[Pinned]" name="pinned"></label>]
      <p><label for="limited"><input type="checkbox" id="limited" name="limited" value="1" [case:[limited]||checked]>[const:ttlLimited]</label>
      <p><label for="invited">[const:ttlInvited]:</label><br><input id="invited" type="text" value="[invited]" name="invited" oninput="OnKeyboard(this)" onkeydown="EditKeyDown(event, this)" getlist="/!usersmatch/">
  </fieldset>

  <fieldset>
  <legend>[const:Content]</legend>
  [case:[special:canupload]||<p><label for="input-file-browse">[const:Attach]:&nbsp;<small>[const:FileLimit]</small>:</label><br><input id="input-file-browse" type="file" name="attach" multiple="multiple" oninput="previewIt();">]

  <p><label><input name="format" type="radio" [case:[format]|checked|] value="0">MiniMag</label>
  <label><input name="format" type="radio" [case:[format]||checked] value="1">BBCode</label>

  [include:edit_toolbar.tpl]

  <center><textarea id="source" name="source" rows="20" cols="20" style="width: stretch; width: -moz-available; width: -webkit-fill-available;">[source]</textarea></center>
  </fieldset>

    <input type="hidden" name="ticket" value="[Ticket]" >

    <p><input formaction="!edit#preview" type="submit" name="preview" onclick="this.form.cmd='preview'" value="[const:btnPreview]" title="[const:hintPreview]">&nbsp;

    <button type="submit" name="submit" onclick="this.form.cmd='submit'" title="[const:hintSubmit]">
      [const:btnSubmit]
      [case:[special:wait2post]||<span id="remains">[const:lblAfter]<span id="remval">[special:wait2post]</span> s</span>]
    </button>&nbsp;
</form>

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


<script src="[special:skin]/highlight.js"></script>
<script src="[special:skin]/file-browse.js"></script>
<script src="[special:skin]/editors.js"></script>
<script src="[special:skin]/autocomplete.js"></script>
<script src="[special:skin]/embeded.js"></script>

