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
    /// Логика взаимодействия для Login.xaml
    /// </summary>
    public partial class Login : Page
    {
        MainWindow main;
        public Login(MainWindow main)
        {
            this.main = main;
            InitializeComponent();
        }

        private void EnterClick(object sender, RoutedEventArgs e)
        {
            
            foreach (Users user in main.bd.Users)
            {
                if ((String.Compare(user.password, password.Password) == 0) && (String.Compare(user.email, email.Text) == 0))
                {
                    main.hasEntered = true;
                    main.user = user;
                    main.MainFrame.Navigate(new Personal(main));
                    
                }
            }
            if (!main.hasEntered)
            {
                MessageBox.Show("Введены неверные данные. Попробуйте снова");
            }

        }
    }
}
