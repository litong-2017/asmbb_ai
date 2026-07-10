[case:[special:lang]|
  [equ:ttlRequest=Reset password request]
  [equ:phUser=Username]
  [equ:phEmail=E-mail]
  [equ:btnSubmit=Submit]
  [equ:helpRequest=
    <p>You have one reset attempt in 24 hours.
    <p>Fill in your user name and the e-mail associated with your account.
    <p>When you click "submit", an email with the password reset link will be sent to your account email address.
    <p>Notice, that if you used invalid email on the registration, the reset process will fail.
    <p>In this case, the only option is to create a new account.
  ]
|
  [equ:ttlRequest=Заявка за възстановяване на парола]
  [equ:phUser=Потребител]
  [equ:phEmail=E-mail]
  [equ:btnSubmit=Изпрати]
  [equ:helpRequest=
    <p>Имате един опит за нулиране на 24 часа.
    <p>Въведете потребителското си име и имейла, свързан с акаунта.
    <p>Когато натиснете "изпрати", ще ви бъде изпратено писмо с връзка за продължаване на процеса.
    <p>Забележете, че ако сде дали невалиден адрес при регистрацията, процеса на нулиране ще е неуспешен.
    <p>В този случай, единственото решение е да създадене нов акаунт.
  ]
|
  [equ:ttlRequest=Запрос сброса пароля]
  [equ:phUser=Потребитель]
  [equ:phEmail=Адрес электронной почты]
  [equ:btnSubmit=Отправить]
  [equ:helpRequest=
    <p>У вас есть одна попытка сброса за 24 часа.
    <p>Введите ваше имя пользователя и адрес электронной почты, связанный с вашей учетной записью.
    <p>Когда вы нажимаете «отправить», на адрес электронной почты вашей учетной записи будет отправлено письмо со ссылкой для сброса пароля.
    <p>Обратите внимание, что если вы использовали неверный адрес электронной почты при регистрации, процесс сброса не удастся.
    <p>В этом случае единственный вариант - создать новую учетную запись.
  ]
|
  [equ:ttlRequest=Réinitialiser la demande de mot de passe]
  [equ:phUser=Nom d'utilisateur]
  [equ:phEmail=Email]
  [equ:btnSubmit=Envoyer]
  [equ:helpRequest=
    <p>Vous avez droit à une réinitialisation toutes les 24h.
    <p>Remplissez le champ nom d'utilisateur et e-mail associé à votre compte.
    <p>Lorque vous cliquez sur "Envoyer", un email comptenant un lien de réinitialisation de mot de passe sera envoyé à votre adresse email.
    <p>Si vous avez fourni un email invalide lors de votre inscription, cela ne fonctionnera pas.
    <p>Dans ce cas, la seule solution est de recréer un compte.
  ]
|
  [equ:ttlRequest=Anforderung der Passwortzurücksetzung]
  [equ:phUser=Benutzername]
  [equ:phEmail=E-Mail-Adresse]
  [equ:btnSubmit=Absenden]
  [equ:helpRegister=
    <p>Ihnen steht eine Zurücksetzung je 24 Stunden zur Verfügung.
    <p>Geben Sie Ihren Benutzernamen und die E-Mail-Adresse Ihres Benutzerkontos an.
    <p>Wenn Sie auf "Absenden" klicken, wird eine E-Mail mit einem Link zur Zurücksetzung des Passworts an Ihre E-Mail-Adresse gesendet.
    <p>Beachten Sie, dass, falls Sie bei der Registrierung eine ungültige E-Mail-Adresse angegeben haben, dieser Vorgang fehlschlagen wird.
    <p>In diesem Fall ist Ihre einzige Option die Registrierung eines neuen Kontos.
  ]
]

<form method="post" action="/!resetpassword/1">

  <h2>[const:ttlRequest]</h2>

  <p><label>[const:phUser]:<br>
  <input type="text" value="" name="username" maxlength="256" autofocus></label>
  <p><label>[const:phEmail]:<br>
  <input type="text" value="" name="email" maxlength="320"></label>

  <input type="hidden" value="[ticket]" name="ticket" id="ticket">
  <p><input type="submit" name="submit" value="[const:btnSubmit]">
</form>

<article>
  [const:helpRequest]
</article>

