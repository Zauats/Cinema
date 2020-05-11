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
    /// Логика взаимодействия для PersonalSettining.xaml
    /// </summary>
    public partial class PersonalSettining : Page
    {

        MainWindow main;
        public PersonalSettining(MainWindow main)
        {
            this.main = main;
            InitializeComponent();
            email.Text = main.user.email;
            name.Text = main.user.name;
            surname.Text = main.user.surname;
            if (String.Compare(main.user.sex, "мужской") == 0)
                sex.SelectedIndex = 0;
            else if (String.Compare(main.user.sex, "женский") == 0)
                sex.SelectedIndex = 1;
        }

        private void SaveClick(object sender, RoutedEventArgs e)
        {
            bool check = true;
            foreach (Users user in main.bd.Users)
                if ((String.Compare(main.user.password, user.password) == 0 && String.Compare(user.email, email.Text) == 0) && !main.user.Equals(user))
                    check = false;

            if (check)
            {
                main.user.email = email.Text;
                main.user.name = name.Text;
                main.user.surname = surname.Text;
                main.user.sex = ((ComboBoxItem)sex.SelectedItem).Content.ToString();
                main.bd.SaveChanges();
                MessageBox.Show("Данные сохранены");
            }
            else
                MessageBox.Show("Пользователь с такими данными уже существует");
        }


        private void ChangePasswordClick(object sender, RoutedEventArgs e)
        {
            if (String.Compare(main.user.password, lastPassword.Text) == 0)
            {
                if (String.Compare(newPassword.Text, checkPassword.Text) == 0)
                {
                    bool check = true;
                    foreach (Users user in main.bd.Users)
                        if (String.Compare(newPassword.Text, user.password) == 0 && String.Compare(user.email, main.user.email) == 0)
                            check = false;

                    if (check)
                    {
                        main.user.password = newPassword.Text;
                        lastPassword.Text = "";
                        newPassword.Text = "";
                        checkPassword.Text = "";
                        main.bd.SaveChanges();
                        MessageBox.Show("Пароль успешно сменен");
                    }
                    else
                        MessageBox.Show("Пользователь с такими данными уже существует");
                }
                else
                    MessageBox.Show("Пароли не совпадают");
            }
            else
                MessageBox.Show("Неверный старый пароль");
        }
    }
}
