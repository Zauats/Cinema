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
using System.Net.Mail;
using System.Net;
using VirtualCinema.DataBase;

namespace VirtualCinema
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    /// 
    public partial class MainWindow : Window
    {

        public bool hasEntered = false;
        public CinemaContent bd;
        public Users user;

        public MainWindow()
        {
            InitializeComponent();
            bd = new CinemaContent();

            MainFrame.Navigate(new Pages.FilmsPage(this));

        }



        private void Frame_Navigated(object sender, NavigationEventArgs e)
        {
            if (!(e.Content is Page page)) return;
        }

        private void FilmPageClick(object sender, RoutedEventArgs e)
        {
            MainFrame.Navigate(new Pages.FilmsPage(this));
        }

        private void AuthorizationPageClick(object sender, RoutedEventArgs e)
        {
            if (hasEntered)
                MainFrame.Navigate(new Pages.Personal(this));
            else
                MainFrame.Navigate(new Pages.Authorization(this));
        }
    }
}
