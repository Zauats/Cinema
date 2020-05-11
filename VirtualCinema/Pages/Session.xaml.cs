﻿using System;
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
    /// Логика взаимодействия для Session.xaml
    /// </summary>
    public partial class Session : Page
    {
        MainWindow main;
        Sessions session;
        double price = 0;
        public Session(MainWindow main, Sessions session)
        {
            this.main = main;
            this.session = session;
            InitializeComponent();
            filmName.Text = session.Films.name;
            ageLimit.Text = "Возрастной рейтинг: "  + session.Films.age_limit.ToString() + "+";

            string timeString = "";
            if (session.hour < 10) timeString = "0";
            timeString += session.hour.ToString() + ":";
            if (session.minutes < 10) timeString += "0";
            timeString += session.minutes.ToString();
            time.Text = "Время сеанса: " + timeString;
            duration.Text = session.Films.duration.ToString() + " мин";
            hall.Text = session.Halls.name;
            fillPlaces();
        }

        private void fillPlaces()
        {
            int row = session.Halls.row_quantity;
            int column = session.Halls.column_quantity;
            places.Children.Clear();
            places.RowDefinitions.Clear();
            places.ColumnDefinitions.Clear();

            for (int i = 0; i < row; i++)
                places.RowDefinitions.Add(new RowDefinition());
            for (int i = 0; i < column; i++)
                places.ColumnDefinitions.Add(new ColumnDefinition());

            bool check = false;
            foreach (Tickets tickets in session.Tickets)
            {
                Rectangle rect = new Rectangle();
                rect.Fill = Brushes.White;
                if (tickets.state)
                    rect.Fill = Brushes.Red;

                rect.DataContext = tickets;
                Grid.SetRow(rect, tickets.Places.row_number);
                Grid.SetColumn(rect, tickets.Places.column_number);
                rect.MouseDown += rectClick;
                places.Children.Add(rect);
                rect.Margin = new Thickness(5, 5, 5, 5);
            }
        }

        private void rectClick(object sender, MouseEventArgs e)
        {
            Rectangle rect = (Rectangle)sender;            if (rect.Fill == Brushes.White)
            {
                rect.Fill = Brushes.Blue;
                price += ((Tickets)rect.DataContext).price;
            }
            else if (rect.Fill == Brushes.Blue)
            {
                rect.Fill = Brushes.White;
                price -= ((Tickets)rect.DataContext).price;
            }
            sumPrice.Text = price.ToString() + " руб";
        }

        private void BuyClick(object sender, RoutedEventArgs e)
        {
            foreach (Rectangle rect in places.Children)
            {
                if (rect.Fill == Brushes.Blue)
                {
                    Tickets ticket = (Tickets)rect.DataContext;
                    ticket.state = true;
                    ticket.user_id = main.user.id;
                }
            }
            main.bd.SaveChanges();
            MessageBox.Show("Спасибо за покупку!");
            main.MainFrame.Navigate(new FilmsPage(main));
        }
    }
}
