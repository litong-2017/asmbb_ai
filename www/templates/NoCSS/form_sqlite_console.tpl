[case:[special:lang]|
  [equ:ttlStmt=SQL statement]
  [equ:btnExec=Exec]
  [equ:btnRevert=Revert]
|
  [equ:ttlStmt=SQL команди]
  [equ:btnExec=Изпълни]
  [equ:btnRevert=Отказ]
|
  [equ:ttlStmt=SQL команды]
  [equ:btnExec=Выполнить]
  [equ:btnRevert=Отказ]
|
  [equ:ttlStmt=SQL statement]
  [equ:btnExec=Exec]
  [equ:btnRevert=Revert]
|
  [equ:ttlStmt=SQL-Statement]
  [equ:btnExec=Ausführen]
  [equ:btnRevert=Zurücksetzen]
]


<form id="editform" action="/!sqlite/#sql_result" method="post">
  <fieldset><legend>[const:ttlStmt]:</legend>
    <textarea name="source" placeholder="SQL code" rows=25 cols=40 style="width: stretch; width: -moz-available; width: -webkit-fill-available;">[source]</textarea>
    <input type="hidden" name="ticket" value="[Ticket]" >
    <p>
    <center><button type="submit">[const:btnExec]</button>&nbsp;<button type="reset">[const:btnRevert]</button></center>
  </fieldset>
</form>

<a id="sql_result"></a>
<font size=1 face=sans-serif>
[html:[result]]
</font>
