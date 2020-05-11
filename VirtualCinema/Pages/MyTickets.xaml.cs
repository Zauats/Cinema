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
    /// Логика взаимодействия для MyTickets.xaml
    /// </summary>
    public partial class MyTickets : Page
    {
        MainWindow main;
        public MyTickets(MainWindow main)
        {
            this.main = main;
            InitializeComponent();
            foreach (Tickets ticket in main.user.Tickets)
            {
                createGrid(ticket);
            }
        }

        private void createGrid(Tickets ticket)
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
            rating.Text = "оценка: " + ticket.Sessions.Films.rating.ToString();

            TextBlock ageLimit = new TextBlock();
            ageLimit.FontSize = 20;
            ageLimit.Foreground = Brushes.White;
            ageLimit.Text = "Возрастное ограничение: " + ticket.Sessions.Films.age_limit.ToString() + "+";

            TextBlock duration = new TextBlock();
            duration.FontSize = 20;
            duration.Foreground = Brushes.White;
            duration.Text = ticket.Sessions.Films.duration.ToString() + " мин";
            panel.Children.Add(ageLimit);
            panel.Children.Add(rating);
            panel.Children.Add(duration);


            TextBlock filmName = new TextBlock();
            filmName.FontSize = 30;
            filmName.Foreground = Brushes.White;
            filmName.Text = ticket.Sessions.Films.name;
            filmName.Margin = new Thickness(38, 0, 0, 0);
            Grid.SetColumn(filmName, 0);
            Grid.SetRow(filmName, 0);

            TextBlock hallType = new TextBlock();
            hallType.FontSize = 30;
            hallType.Foreground = Brushes.White;
            hallType.Text = ticket.Sessions.Session_types.session_type;
            hallType.Margin = new Thickness(38, 40, 0, 0);
            Grid.SetColumn(hallType, 0);
            Grid.SetRow(hallType, 0);

            grid.Children.Add(hallType);
            grid.Children.Add(panel);
            grid.Children.Add(filmName);

            StackPanel info = new StackPanel();
            Grid.SetColumn(info, 1);
            Grid.SetRowSpan(info, 2);

            TextBlock hallName = new TextBlock();
            hallName.FontSize = 30;
            hallName.Foreground = Brushes.White;
            hallName.Text = ticket.Sessions.Halls.name;
            info.Children.Add(hallName);

            TextBlock rowNum = new TextBlock();
            rowNum.FontSize = 30;
            rowNum.Foreground = Brushes.White;
            rowNum.Text = "Ряд " + ticket.Places.row_number.ToString();
            info.Children.Add(rowNum);

            TextBlock placeNum = new TextBlock();
            placeNum.FontSize = 30;
            placeNum.Foreground = Brushes.White;
            placeNum.Text = "Место " +ticket.Places.column_number.ToString();
            info.Children.Add(placeNum);

            TextBlock startTime = new TextBlock();
            startTime.FontSize = 30;
            startTime.Foreground = Brushes.White;
            string timeString = "";
            if (ticket.Sessions.hour < 10) timeString = "0";
            timeString += ticket.Sessions.hour.ToString() + ":";
            if (ticket.Sessions.minutes < 10) timeString += "0";
            timeString += ticket.Sessions.minutes.ToString();
            startTime.Text = "Начало в " + timeString;
            info.Children.Add(startTime);

            TextBlock price = new TextBlock();
            price.FontSize = 30;
            price.Foreground = Brushes.White;
            price.Text = "Стоимость: " + ticket.price.ToString();
            info.Children.Add(price);


            grid.Children.Add(info);

            tickets.Children.Add(grid);
        }
    }
}
