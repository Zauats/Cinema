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

namespace VirtualCinema.Pages
{
    /// <summary>
    /// Логика взаимодействия для Personal.xaml
    /// </summary>
    public partial class Personal : Page
    {



        MainWindow main;
        public Personal(MainWindow main)
        {
            this.main = main;
            InitializeComponent();
            welcomMessage.Text = "Здравствуйте, " + main.user.name + "!";
            if (!main.user.is_admin ?? true)
            {
                cinemaButton.Visibility = Visibility.Hidden;
                FilmButton.Visibility = Visibility.Hidden;
                hallButton.Visibility = Visibility.Hidden;
                sessionButton.Visibility = Visibility.Hidden;
            }

        }

        private void LogOutClick(object sender, RoutedEventArgs e)
        {
            main.hasEntered = false;
            main.user = null;
            main.MainFrame.Navigate(new Pages.Authorization(main));

        }

        private void MyTicketsClick(object sender, RoutedEventArgs e)
        {
            
            PersonalFrame.Navigate(new Pages.MyTickets(main));
        }

        private void ChangeDataClick(object sender, RoutedEventArgs e)
        {
            PersonalFrame.Navigate(new PersonalSettining(main));
        }

        private void CreateCinemaClick(object sender, RoutedEventArgs e)
        {
            PersonalFrame.Navigate(new AdminMode.CreateCinema(main));
        }

        private void CreateHallsClick(object sender, RoutedEventArgs e)
        {
            if (main.bd.Cinemas.Count() > 0)
                PersonalFrame.Navigate(new AdminMode.CreateHall(main));
            else
                MessageBox.Show("Нужен кинотеатр");
        }

        private void CreateFilmClick(object sender, RoutedEventArgs e)
        {
            PersonalFrame.Navigate(new AdminMode.CreateFilm(main));
        }

        private void CreateSessionClick(object sender, RoutedEventArgs e)
        {
            bool check = true;
            if (main.bd.Halls.Count() == 0)
            {
                MessageBox.Show("Нужен хотя-бы один зал");
                check = false;
            }
            else if (main.bd.Films.Count() == 0)
            {
                MessageBox.Show("Нужен хотя-бы один фильм");
                check = false;
            }
            if (check)
                PersonalFrame.Navigate(new AdminMode.CreateSession(main));
        }
    }
}
