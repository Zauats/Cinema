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
    /// Логика взаимодействия для Films.xaml
    /// </summary>
    public partial class FilmsPage : Page
    {
        MainWindow main;
        public FilmsPage(MainWindow main)
        {
            this.main = main;
            InitializeComponent();
            date.SelectedDate = DateTime.Now;
            foreach (Films film in main.bd.Films)
            {
                createGrid(film);
            }
            date.SelectedDateChanged += changeDate;
        }

        private void changeDate(object sender, SelectionChangedEventArgs e)
        {
            sessions.Children.Clear();
            foreach (Films film in main.bd.Films)
            {
                createGrid(film);
            }
        }

        private void createGrid(Films film)
        {
            Grid grid = new Grid();
            grid.Margin = new Thickness(0, 100, 0, 0);
            Border border = new Border();
            border.BorderThickness = new Thickness(2, 2, 2, 2);
            border.CornerRadius = new CornerRadius(10);
            border.BorderBrush = Brushes.White;
            Grid.SetColumnSpan(border, 2);
            Grid.SetRowSpan(border, 2);
            grid.Children.Add(border);
            grid.ColumnDefinitions.Add(new ColumnDefinition());
            grid.ColumnDefinitions.Add(new ColumnDefinition());
            grid.RowDefinitions.Add(new RowDefinition());
            grid.RowDefinitions.Add(new RowDefinition());

            StackPanel panel = new StackPanel();
            panel.Margin = new Thickness(38, 0, 0, 0);
            Grid.SetColumn(panel, 0);
            Grid.SetRow(panel, 1);
            TextBlock rating = new TextBlock();
            rating.FontSize = 20;
            rating.Foreground = Brushes.White;
            rating.Text = "оценка: " + film.rating.ToString();

            TextBlock ageLimit = new TextBlock();
            ageLimit.FontSize = 20;
            ageLimit.Foreground = Brushes.White;
            ageLimit.Text = "Возрастной рейтинг: " + film.age_limit.ToString() + "+";

            TextBlock duration = new TextBlock();
            duration.FontSize = 20;
            duration.Foreground = Brushes.White;
            duration.Text = film.duration.ToString() + " мин";
            panel.Children.Add(ageLimit);
            panel.Children.Add(rating);
            panel.Children.Add(duration);



            TextBlock filmName = new TextBlock();
            filmName.FontSize = 30;
            filmName.Foreground = Brushes.White;
            filmName.Text = film.name;
            filmName.Margin = new Thickness(38, 0, 0, 0);
            grid.Children.Add(panel);
            grid.Children.Add(filmName);

            StackPanel shedule = new StackPanel();
            Grid.SetColumn(shedule, 1);
            Grid.SetRowSpan(shedule, 2);


            foreach (Session_types type in main.bd.Session_types)
            {
                StackPanel typePanel = new StackPanel();
                typePanel.Orientation = Orientation.Horizontal;
                typePanel.Height = 60;
                TextBlock typeText = new TextBlock();
                typeText.Foreground = Brushes.White;
                typeText.FontSize = 20;
                typeText.Margin = new Thickness(-400, 20, 30, 0);
                typeText.Width = 150;
                typeText.Text = type.session_type;
                typePanel.Children.Add(typeText);

                foreach (Sessions session in film.Sessions)
                {
                    if ((session.Session_types.id == type.id) && (date.SelectedDate.GetValueOrDefault().Day == session.data.Day)
                        && (date.SelectedDate.GetValueOrDefault().Month == session.data.Month) && (date.SelectedDate.GetValueOrDefault().Year == session.data.Year))
                    {
                        string timeString = "";
                        if (session.hour < 10) timeString = "0";
                        timeString += session.hour.ToString() + ":";
                        if (session.minutes < 10) timeString += "0";
                        timeString += session.minutes.ToString();


                        TextBlock sessionText = new TextBlock();
                        sessionText.Text = timeString;
                        sessionText.Foreground = Brushes.White;
                        sessionText.FontSize = 20;
                        sessionText.Margin = new Thickness(0, 20, 30, 0);
                        sessionText.TextAlignment = TextAlignment.Center;
                        sessionText.MouseDown += textClick;
                        sessionText.DataContext = session;
                        typePanel.Children.Add(sessionText);
                    }
                }
                if (typePanel.Children.Count > 1)
                {
                    shedule.Children.Add(typePanel);
                }
            }

            grid.Children.Add(shedule);
            if (shedule.Children.Count > 0)
                sessions.Children.Add(grid);
        }

        private void textClick(object sender, MouseEventArgs e)
        {
            if (main.hasEntered)
                main.MainFrame.Navigate(new Session(main, (Sessions)((TextBlock)sender).DataContext));
            else
            {
                MessageBox.Show("Для покупки билетов требуется авторизация");
            }
        }
    }
}
