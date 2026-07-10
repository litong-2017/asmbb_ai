[case:[special:lang]|
  [equ:pDirections=Check your mail box for confirmation e-mail. Copy the <b>secret code</b> from the e-mail to this form "Secret token" field. Fill in <b>all</b> remaining fields. Submit the form.]
  [equ:ttlTitle=Reset password]
  [equ:phUser=Username]
  [equ:phEmail=e-mail]
  [equ:phSecret=Secret token]
  [equ:phPass=Password]
  [equ:phPass2=Password again]
  [equ:btnSubmit=Submit]
  [equ:helpRegister=
    <p>To choose strong password and write it down on a paper is better than to choose easy to remember password.
    <p>Because the humans are not very good in remembering random strings, but pretty good in keeping small sheets of paper.
    <p>But don't stick it on your monitor. Simply keep it in your wallet...
    <p>... or use some password manager program.
  ]
|
  [equ:pDirections=Вижте пощата си за потвърждаващ имейл. Копирайте <b>тайния код</b> от имейла в полето "таен код" на тази форма. Попълнете <b>всички</b> останали полета. Изпратете формата.]
  [equ:ttlTitle=Възстановяване на паролата]
  [equ:phUser=Потребител]
  [equ:phEmail=e-mail]
  [equ:phSecret=Таен код]
  [equ:phPass=Парола]
  [equ:phPass2=Паролата още веднъж]
  [equ:btnSubmit=Изпрати]
  [equ:helpRegister=
    <p>По добре да си изберете силна парола и да я запишете на листче, отколкото да си изберете лесна за запомняне парола.
    <p>Защото хората не са много добри в помнене на случайни символи, но са много добре в пазенето на малки листчета хартия.
    <p>Само не лепете листчето на монитора! Просто го сложете в портфейла си...
    <p>... или използвайте програма – менажер на пароли.
  ]
|
  [equ:pDirections=Проверьте свой почтовый ящик для подтверждения по электронной почте. Скопируйте <b>секретный код</b> из электронного письма в поле формы «секретный код». Заполните <b>все</b> оставшиеся поля. Отправьте форму.]
  [equ:ttlTitle=Восстановление пароля]
  [equ:phUser=Потребитель]
  [equ:phEmail=Адрес электронной почты]
  [equ:phSecret=Секретный код]
  [equ:phPass=Пароль]
  [equ:phPass2=Пароль еще раз]
  [equ:btnSubmit=Отправить]
  [equ:helpRegister=
    <p>Лучше выбрать надежный пароль и написать его на бумаге, чем выбрать пароль, которого легко запомнить.
    <p>Потому что люди не очень хорошо запоминают случайные символы, но хорошо умеют хранить бумаги.
    <p>Только не наклеивайте пароль на монитор! Просто положите его в свой кошелек...
    <p>...или используйте программу менеджера паролей.
  ]
|
  [equ:pDirections=Consulter vos emails pour confirmer votre adresse. Copiez le <b>code secret</b> dans le champ "Clé secrète" de ce formulaire. Remplissez <b>tous</b> les champs restants et envoyez le formulaire.]
  [equ:ttlTitle=Réinitialiser le mot de passe]
  [equ:phUser=Nom d'utilisateur]
  [equ:phEmail=email]
  [equ:phSecret=Clé secrète]
  [equ:phPass=Mot de passe]
  [equ:phPass2=Retaper le mot de passe]
  [equ:btnSubmit=Envoyer]
  [equ:helpRegister=
    <p>Choisir un mot de passe compliqué et l'écrire sur un papier vaut mieux qu'un mot de passe trop simple.
    <p>Les humains ne sont pas vraiment capables de se souvenir de mot de cominaisons compliquées mais sont meilleurs pour garder des bouts de papiers.
    <p>Mais ne les collez pas sur votre écran. Gardez-les plutôt dans une pochette ...
    <p>... ou utiliser un gestionnaire de mots de passe.
  ]
|
  [equ:pDirections=Überprüfen Sie Ihr Postfach - Sie sollten eine Bestätigungs-E-Mail erhalten haben. Kopieren Sie den <b>geheimen Code</b> aus der E-Mail in das Feld für den geheimen Code. Füllen Sie <b>alle</b> weiteren Felder aus. Dann schicken Sie das
Formular ab.]
  [equ:ttlTitle=Passwort zurücksetzen]
  [equ:phUser=Benutzername]
  [equ:phEmail=E-Mail-Adresse]
  [equ:phSecret=Geheimer Code]
  [equ:phPass=Passwort]
  [equ:phPass2=Passwort (noch mal)]
  [equ:btnSubmit=Absenden]
  [equ:helpRegister=
    <p>Ein starkes Passwort zu wählen und es aufzuschreiben ist besser als eines zu verwenden, das Sie sich leicht merken können.
    <p>Weil Menschen nicht besonders gut darin sind, sich zufällige Zeichenfolgen zu merken, aber ziemlich gut darin, kleine Stücke Papier aufzubewahren.
    <p>Aber kleben Sie es nicht an Ihren Bildschirm. Stecken Sie es einfach in Ihr Portemonnaie...
    <p>... oder benutzen Sie irgendein Programm zur Passwortverwaltung-
  ]
]

<hr size=1>

<p>[const:pDirections]

<form method="post" action="/!resetpassword/3">
  <h2>[const:ttlTitle]</h2>

  <p><label>[const:phUser]:<br>
  <input type="text" name="username" maxlength="256" autofocus></label>
  <p><label>[const:phEmail]:<br>
  <input type="text" name="email" maxlength="320"></label>
  <p><label>[const:phSecret]:<br>
  <input type="text" name="secret" maxlength="32"></label>
  <p><label>[const:phPass]:<br>
  <input type="password" name="password" maxlength="1024" autocomplete="off"></label>
  <p><label>[const:phPass2]:<br>
  <input type="password" name="password2" maxlength="1024" autocomplete="off"></label>

  <input type="hidden" value="[ticket]" name="ticket" id="ticket">

  <p><input type="submit" name="submit" value="[const:btnSubmit]">
</form>
  
<article>
    [const:helpRegister]
</article>

