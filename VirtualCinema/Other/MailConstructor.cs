using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Mail;
using System.Net;

namespace VirtualCinema.Other
{
    static class MailConstructor
    {
        public static void send(string subject, string body, string email)
        {
            SendEmailAsync(subject, body, email).GetAwaiter();
        }

        private static async Task SendEmailAsync(string subject, string body, string email)
        {
            MailAddress from = new MailAddress("cfif12342002@yandex.ru", "CinemaCompany");
            MailAddress to = new MailAddress(email);
            MailMessage m = new MailMessage(from, to);
            m.Subject = subject;
            m.Body = body;
            SmtpClient smtp = new SmtpClient("smtp.yandex.ru", 25);

            smtp.Credentials = new NetworkCredential("cfif12342002@yandex.ru", "3438681");
            smtp.EnableSsl = true;
            await smtp.SendMailAsync(m);
            Console.WriteLine("Письмо отправлено");
        }
    }
}
