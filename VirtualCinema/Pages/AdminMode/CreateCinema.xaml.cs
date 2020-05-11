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

namespace VirtualCinema.Pages.AdminMode
{
    /// <summary>
    /// Логика взаимодействия для CreateCinema.xaml
    /// </summary>
    public partial class CreateCinema : Page
    {
        MainWindow main;
        Cinemas cinema;
        Button button;
        public CreateCinema(MainWindow main)
        {
            this.main = main;
            InitializeComponent();
            
            foreach(Cinemas cinema in main.bd.Cinemas)
            {
                Button button = new Button();
                button.Content = cinema.id + ": " + cinema.name;
                button.FontSize = 15;
                button.Click += CinemaClick;
                button.DataContext = cinema;
                cinemas.Children.Add(button);
            }
        }

        private void CinemaClick(object sender, RoutedEventArgs e)
        {
            Cinemas cinema = (Cinemas)((Button)sender).DataContext;
            deleteCinemaButton.Visibility = Visibility.Visible;
            changeCinemaButton.Visibility = Visibility.Visible;
            cinemaName.Text = cinema.name;
            cinemaAdress.Text = cinema.adress;
            cinemaStars.Text = cinema.stars_quantity.ToString();
            nearestMetro.Text = cinema.nearest_metro;
            this.cinema = cinema;
            this.button = (Button)sender;
        }

        private void CreateCinemaClick(object sender, RoutedEventArgs e)
        {
            bool check = true;
            Cinemas cinema = new Cinemas();
            cinema.name = cinemaName.Text;
            cinema.adress = cinemaAdress.Text;
            try
            {
                cinema.stars_quantity = Convert.ToInt32(cinemaStars.Text);
            }
            catch
            {
                check = false;
            }
            cinema.nearest_metro = nearestMetro.Text;

            int i = -1; bool isFindId = true;
            while (isFindId)
            {
                i++;
                isFindId = false;
                foreach (Cinemas kino in main.bd.Cinemas)
                {
                    if (kino.id == i)
                        isFindId = true;
                }
            }
            cinema.id = i;

            if (check)
            {
                main.bd.Cinemas.Add(cinema);
                main.bd.SaveChanges();
                Button button = new Button();
                button.Content = cinema.id + ": " + cinema.name;
                button.FontSize = 15;
                button.Click += CinemaClick;
                button.DataContext = cinema;
                cinemas.Children.Add(button);
            }
            else
                MessageBox.Show("Проблемы со звездами");
        }

        private void DeleteCinemaClick(object sender, RoutedEventArgs e)
        {
            main.bd.Cinemas.Remove(cinema);
            main.bd.SaveChanges();
            cinemas.Children.Remove(button);
            changeCinemaButton.Visibility = Visibility.Hidden;
            deleteCinemaButton.Visibility = Visibility.Hidden;
        }


        private void ChangeCinemaClick(object sender, RoutedEventArgs e)
        {
            bool check = true;
            cinema.name = cinemaName.Text;
            cinema.adress = cinemaAdress.Text;
            try
            {
                cinema.stars_quantity = Convert.ToInt32(cinemaStars.Text);
            }
            catch
            {
                check = false;
            }
            cinema.nearest_metro = nearestMetro.Text;

            if (check)
            {
                main.bd.SaveChanges();
                button.Content = cinema.id + ": " + cinema.name;
            }
            else
                MessageBox.Show("Проблемы со звездами");
        }
    }
}
