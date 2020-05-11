using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using VirtualCinema.DataBase;

namespace VirtualCinema.Pages
{
    /// <summary>
    /// Логика взаимодействия для Registration.xaml
    /// </summary>
    public partial class Registration : Page
    {

        MainWindow main;
        int code;
        public Registration(MainWindow main)
        {
            this.main = main;
            InitializeComponent();
        }


        private void Confirm_Click(object sender, RoutedEventArgs e)
        {
            if (String.Compare(checkEmail.Text, code.ToString()) == 0) { 
                Users user = new Users();
                user.email = email.Text;
                user.login = email.Text;
                user.name = name.Text;
                user.surname = surname.Text;
                user.password = password.Text;
                user.id = main.bd.Users.Count();
                user.sex = "не выбрано";
                user.is_admin = false;
                main.bd.Users.Add(user);
                main.bd.SaveChanges();
                MessageBox.Show("Регистрация прошла успешно");
                email.Text = "email";
                name.Text = "имя";
                surname.Text = "фамилия";
                password.Text = "придумайте пароль";
                checkPassword.Text = "повторите, что бы не ошибиться";
                checkEmail.Visibility = Visibility.Hidden;
                checkEmailImage.Visibility = Visibility.Hidden;
                checkEmailButton.Visibility = Visibility.Hidden;
            }
            else
            {
                MessageBox.Show("Неверный код подтверждения");
            }
        }

        private void Registration_Click(object sender, RoutedEventArgs e)
        {
            if (IsValidEmail(email.Text) && (password.Text.Equals(checkPassword.Text)))
            {
                bool check = true;
                foreach (Users user in main.bd.Users)
                {
                    if ((String.Compare(user.password, password.Text) == 0) && (String.Compare(user.email, email.Text) == 0))
                    {
                        check = false;
                    }
                }
                if (check)
                {
                    MessageBox.Show("Вам на почту было отправленно письмо с кодом подтверждения");
                    checkEmail.Visibility = Visibility.Visible;
                    checkEmailImage.Visibility = Visibility.Visible;
                    checkEmailButton.Visibility = Visibility.Visible;
                    code = new Random().Next(100000, 999999);
                    Other.MailConstructor.send("Подтверждение аккаунта", "Код подтверждения: " + code.ToString(), email.Text);
                }
                else
                {
                    MessageBox.Show("Хм... не слишком ли много совпадений?");
                }
            }
            else
            {
                if (!IsValidEmail(email.Text))
                    MessageBox.Show("Некорректный email-адрес");
                else if (!password.Text.Equals(checkPassword.Text))
                    MessageBox.Show("Пароли не совпадают");
            }
        }

        private bool IsValidEmail(string email)
        {
            try
            {   
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }
    }
}
