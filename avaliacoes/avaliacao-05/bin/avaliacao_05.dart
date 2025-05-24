//import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

/*
Crie um programa cliente DART que usa a API do Gmail para enviar email para o GMAIL. 
Verificar o código exemplo em https://github.com/ricdtaveira/mobdev-parte-01/tree/master/17-acesso-rede no item SMTP. 
Evidencie o código e a execução do mesmo com prints que evidenciam a entrega do Email para uma determinada no Gmail 
(que pode ser a sua conta pessoal ou a conta DE EMAIL do IFCE).

Observação: Considere o exemplo do código do item 17.4 em https://github.com/ricdtaveira/mobdev-parte-01/blob/master/17-acesso-rede/README.md.
*/

main() async {
  // Configura as credenciais SMTP do Gmail
  final smtpServer = gmail('pedro.barbosa40@aluno.ifce.edu.br', 'sxow zvrm wsjy nmue');

  // Cria uma mensagem de e-mail
  final message = Message()
    ..from = Address('pedro.barbosa40@aluno.ifce.edu.br', 'Pedro')
    ..recipients.add('pedro.barbosa.phab@gmail.com')
    ..subject = 'Boa tarde'
    ..text = 'Já está na hora de ir pra cama.';

  try {
    // Envia o e-mail usando o servidor SMTP do Gmail
    final sendReport = await send(message, smtpServer);

    // Exibe o resultado do envio do e-mail
    print('E-mail enviado: $sendReport');
  } on MailerException catch (e) {
    // Exibe informações sobre erros de envio de e-mail
    print('Erro ao enviar e-mail: ${e.toString()}');
  }
}
