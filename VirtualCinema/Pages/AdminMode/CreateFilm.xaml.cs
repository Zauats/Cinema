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
    /// Логика взаимодействия для CreateFilm.xaml
    /// </summary>
    public partial class CreateFilm : Page
    {
        MainWindow main;
        Films film;
        Button button;

        public CreateFilm(MainWindow main)
        {
            this.main = main;
            InitializeComponent();
            foreach (Films film in main.bd.Films)
            {
                Button button = new Button();
                button.Content = film.id + ": " + film.name;
                button.FontSize = 15;
                button.Click += FilmClick;
                button.DataContext = film;
                films.Children.Add(button);
            }
        }

        private void FilmClick(object sender, RoutedEventArgs e)
        {
            Films film = (Films)((Button)sender).DataContext;
            deleteFilmButton.Visibility = Visibility.Visible;
            changeFilmButton.Visibility = Visibility.Visible;
            filmName.Text = film.name;
            filmRating.Text = film.rating.ToString();
            filmDuration.Text = film.duration.ToString();
            filmAgeLimit.Text = film.age_limit.ToString();
            this.film = film;
            this.button = (Button)sender;
        }


        private void CreateFilmClick(object sender, RoutedEventArgs e)
        {
            bool check = true;
            Films film = new Films();
            film.name = filmName.Text;

            try
            {
                film.rating = Convert.ToInt32(filmRating.Text);
                film.duration = Convert.ToInt32(filmDuration.Text);
                film.age_limit = Convert.ToInt32(filmAgeLimit.Text);
            }
            catch
            {
                check = false;
            }

            int i = -1; bool isFindId = true;
            while (isFindId)
            {
                i++;
                isFindId = false;
                foreach (Films kino in main.bd.Films)
                {
                    if (kino.id == i)
                        isFindId = true;
                }
            }
            film.id = i;

            if (check)
            {
                main.bd.Films.Add(film);
                main.bd.SaveChanges();
                Button button = new Button();
                button.Content = film.id + ": " + film.name;
                button.FontSize = 15;
                button.Click += FilmClick;
                button.DataContext = film;
                films.Children.Add(button);
            }
            else
                MessageBox.Show("Проверьте корректность введенных данных");
        }

        private void DeleteFilmClick(object sender, RoutedEventArgs e)
        {
            main.bd.Films.Remove(film);
            main.bd.SaveChanges();
            films.Children.Remove(button);
            changeFilmButton.Visibility = Visibility.Hidden;
            deleteFilmButton.Visibility = Visibility.Hidden;
        }

        private void ChangeFilmClick(object sender, RoutedEventArgs e)
        {
            bool check = true;
            film.name = filmName.Text;
            try
            {
                film.rating = Convert.ToInt32(filmRating.Text);
                film.duration = Convert.ToInt32(filmDuration.Text);
                film.age_limit = Convert.ToInt32(filmAgeLimit.Text);
            }
            catch
            {
                check = false;
            }

            if (check)
            {
                main.bd.SaveChanges();
                button.Content = film.id + ": " + film.name;
            }
            else
                MessageBox.Show("Проверьте корректность введенных данных");
        }
    }
}
