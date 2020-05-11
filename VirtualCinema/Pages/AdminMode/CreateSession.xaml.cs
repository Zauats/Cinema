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
    /// Логика взаимодействия для CreateSession.xaml
    /// </summary>
    public partial class CreateSession : Page
    {
        MainWindow main;
        Session_types session_type;
        Button sessionTypeButton;
        Sessions session;
        Button sessionButton;


        public CreateSession(MainWindow main)
        {
            this.main = main;
            InitializeComponent();

            foreach (Session_types session_Type in main.bd.Session_types)
            {
                Button button = new Button();
                button.Content = session_Type.session_type;
                button.FontSize = 15;
                button.Click += SessionTypeClick;
                button.DataContext = session_Type;
                sessionTypes.Children.Add(button);

                ComboBoxItem comboBox = new ComboBoxItem();
                comboBox.Content = session_Type.session_type;
                comboBox.FontSize = 15;
                comboBox.DataContext = session_Type;
                sessionType.Items.Add(comboBox);


            }

            foreach (Sessions session in main.bd.Sessions)
            {
                string timeString = "";
                if (session.hour < 10) timeString = "0";
                timeString += session.hour.ToString() + ":";
                if (session.minutes < 10) timeString += "0";
                timeString += session.minutes.ToString();
                Button button = new Button();
                button.Content = main.bd.Films.Find(session.film_id).name + " " + session.data.ToShortDateString() + " " + timeString;
                button.FontSize = 15;
                button.Click += SessionClick;
                button.DataContext = session;
                sessions.Children.Add(button);
            }

            foreach (Cinemas cinema in main.bd.Cinemas)
            {
                ComboBoxItem comboBox = new ComboBoxItem();
                comboBox.Content = cinema.id + ": " + cinema.name;
                comboBox.FontSize = 15;
                comboBox.DataContext = cinema;
                cinemas.Items.Add(comboBox);
            }
            cinemas.SelectedIndex = 0;

            foreach (Films film in main.bd.Films)
            {
                ComboBoxItem comboBox = new ComboBoxItem();
                comboBox.Content = film.name;
                comboBox.FontSize = 15;
                comboBox.DataContext = film;
                films.Items.Add(comboBox);
            }
            films.SelectedIndex = 0;
            changeHalls();
        }

        private void changeHalls()
        {
            Cinemas cinema = ((Cinemas)((ComboBoxItem)cinemas.SelectedItem).DataContext);
            halls.Items.Clear();
            foreach (Halls hall in cinema.Halls)
            {
                ComboBoxItem comboBox = new ComboBoxItem();
                comboBox.Content = hall.id.ToString() + ": " + hall.name;
                comboBox.FontSize = 15;
                comboBox.DataContext = hall;
                halls.Items.Add(comboBox);
            }
            halls.SelectedIndex = 0;
        }

        private void SessionTypeClick(object sender, RoutedEventArgs e)
        {
            Session_types session_type = (Session_types)((Button)sender).DataContext;
            deleteSessionTypeButton.Visibility = Visibility.Visible;
            changeSessionTypeButton.Visibility = Visibility.Visible;
            sessionTypeName.Text = session_type.session_type;
            this.session_type = session_type;
            this.sessionTypeButton = (Button)sender;
        }

        private void SessionClick(object sender, RoutedEventArgs e)
        {
            Sessions session = (Sessions)((Button)sender).DataContext;
            deleteSessionButton.Visibility = Visibility.Visible;
            changeSessionButton.Visibility = Visibility.Visible;
            foreach (ComboBoxItem item in sessionType.Items)
            {
                if (((Session_types)item.DataContext).id == session.session_type)
                    sessionType.SelectedItem = item;
            }

            foreach (ComboBoxItem item in films.Items)
            {
                if (((Films)item.DataContext).id == session.film_id)
                    films.SelectedItem = item;
            }

            foreach (ComboBoxItem item in cinemas.Items)
            {
                if (((Cinemas)item.DataContext).id == session.Halls.Cinemas.id)
                {
                    cinemas.SelectedItem = item;
                    changeHalls();
                }
            }

            foreach (ComboBoxItem item in halls.Items)
            {
                if (((Halls)item.DataContext).id == session.hall_id)
                    halls.SelectedItem = item;
            }
            sessionPrice.Text = session.Tickets.First().price.ToString();

            sessionDate.SelectedDate = session.data;
            startMinutes.Text = session.minutes.ToString();
            startHours.Text = session.hour.ToString();

            this.session = session;
            this.sessionButton = (Button)sender;
        }

        private void CreateSessionTypeClick(object sender, RoutedEventArgs e)
        {
            Session_types type = new Session_types();
            type.session_type = sessionTypeName.Text;

            int i = -1; bool isFindId = true;
            while (isFindId)
            {
                i++;
                isFindId = false;
                foreach (Session_types session_type in main.bd.Session_types)
                {
                    if (session_type.id == i)
                        isFindId = true;
                }
            }
            type.id = i;

            main.bd.Session_types.Add(type);
            main.bd.SaveChanges();
            Button button = new Button();
            button.Content = type.session_type;
            button.FontSize = 15;
            button.Click += SessionTypeClick;
            button.DataContext = type;
            sessionTypes.Children.Add(button);

            ComboBoxItem item = new ComboBoxItem();
            item.Content = type.session_type;
            item.DataContext = type;
            sessionType.Items.Add(item);
        }

        private void DeleteSessionTypeClick(object sender, RoutedEventArgs e)
        {
            main.bd.Session_types.Remove(session_type);
            main.bd.SaveChanges();
            sessionTypes.Children.Remove(sessionTypeButton);



            foreach (ComboBoxItem item in sessionType.Items)
            {
                if (((Session_types)item.DataContext).id == session_type.id)
                {
                    sessionType.Items.Remove(item);
                    break;
                }
            }


            changeSessionTypeButton.Visibility = Visibility.Hidden;
            deleteSessionTypeButton.Visibility = Visibility.Hidden;
        }

        private void ChangeSessionTypeClick(object sender, RoutedEventArgs e)
        {
            session_type.session_type = sessionTypeName.Text;
            main.bd.SaveChanges();
            sessionTypeButton.Content = session_type.session_type;

            foreach (ComboBoxItem item in sessionType.Items)
                if (((Session_types)item.DataContext).id == session_type.id)
                    item.Content = sessionTypeName.Text;
        }


        private void DeleteSessionClick(object sender, RoutedEventArgs e)
        {
            main.bd.Sessions.Remove(session);
            main.bd.SaveChanges();

            sessions.Children.Remove(sessionButton);
            changeSessionButton.Visibility = Visibility.Hidden;
            deleteSessionButton.Visibility = Visibility.Hidden;
        }

        private void ChangeSessionClick(object sender, RoutedEventArgs e)
        {
            bool check = true;
            hallAllert.Visibility = Visibility.Hidden;
            filmAllert.Visibility = Visibility.Hidden;
            typeAllert.Visibility = Visibility.Hidden;
            dateAllert.Visibility = Visibility.Hidden;

            if (halls.Items.Count > 0)
                session.hall_id = ((Halls)((ComboBoxItem)halls.SelectedItem).DataContext).id;
            else
            {
                check = false;
                hallAllert.Visibility = Visibility.Visible;
            }

            if (films.Items.Count > 0)
                session.film_id = ((Films)((ComboBoxItem)films.SelectedItem).DataContext).id;
            else
            {
                check = false;
                filmAllert.Visibility = Visibility.Visible;
            }

            if (sessionType.Items.Count > 0)
                session.session_type = ((Session_types)((ComboBoxItem)sessionType.SelectedItem).DataContext).id;
            else
            {
                check = false;
                typeAllert.Visibility = Visibility.Visible;
            }

            DateTime date;
            try
            {
                int hours = Convert.ToInt32(startHours.Text);
                int minutes = Convert.ToInt32(startMinutes.Text);
                
                if (hours < 24 && hours > 0 && minutes > -1 && minutes < 61)
                {

                    date = new DateTime(sessionDate.SelectedDate.Value.Year, sessionDate.SelectedDate.Value.Month, sessionDate.SelectedDate.Value.Day, hours, minutes, 0);
                    DateTime nowDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second);
                    if (nowDate > date)
                    {
                        dateAllert.Visibility = Visibility.Visible;
                        dateAllert.Text = "выбранная дата уже прошла";
                        check = false;
                    }
                    session.data = date;
                    session.hour = hours;
                    session.minutes = minutes;
                }
                else
                {
                    dateAllert.Visibility = Visibility.Visible;
                    dateAllert.Text = "проверьте корректность введенного времени";
                    check = false;
                }
            }
            catch
            {
                dateAllert.Visibility = Visibility.Visible;
                dateAllert.Text = "Проверьте корректность введенной даты";
                check = false;
            }

            if (check)
            {
                main.bd.SaveChanges();
                string timeString = "";
                if (session.hour < 10) timeString = "0";
                timeString += session.hour.ToString() + ":";
                if (session.minutes < 10) timeString += "0";
                timeString += session.minutes.ToString();
                sessionButton.Content = main.bd.Films.Find(session.film_id).name + " " + session.data.ToShortDateString() + " " + timeString;
            }
            else
            {
                MessageBox.Show("Произошла ошибка");
            }
        }

        private void CreateSessionClick(object sender, RoutedEventArgs e)
        {
            hallAllert.Visibility = Visibility.Hidden;
            filmAllert.Visibility = Visibility.Hidden;
            typeAllert.Visibility = Visibility.Hidden;
            dateAllert.Visibility = Visibility.Hidden;
            priceAllert.Visibility = Visibility.Hidden;

            bool check = true;
            Sessions session = new Sessions();
            int price = 0;
            try
            {
                price = Convert.ToInt32(sessionPrice.Text);
            }
            catch
            {
                check = false;
                priceAllert.Visibility = Visibility.Visible;
            }

            int i = -1; bool isFindId = true;
            while (isFindId)
            {
                i++;
                isFindId = false;
                foreach (Sessions sessions in main.bd.Sessions)
                {
                    if (sessions.id == i)
                        isFindId = true;
                }
            }
            session.id = i;

            if (halls.SelectedIndex != -1)
            {
                session.hall_id = ((Halls)((ComboBoxItem)halls.SelectedItem).DataContext).id;
            }
            else
            {
                check = false;
                hallAllert.Visibility = Visibility.Visible;
            }

            if (films.SelectedIndex != -1)
                session.film_id = ((Films)((ComboBoxItem)films.SelectedItem).DataContext).id;
            else
            {
                check = false;
                filmAllert.Visibility = Visibility.Visible;
            }

            if (sessionType.SelectedIndex != -1)
                session.session_type = ((Session_types)((ComboBoxItem)sessionType.SelectedItem).DataContext).id;
            else
            {
                check = false;
                typeAllert.Visibility = Visibility.Visible;
            }

            DateTime date;
            try
            {
                int hours = Convert.ToInt32(startHours.Text);
                int minutes = Convert.ToInt32(startMinutes.Text);
                
                if (hours < 24 && hours > 0 && minutes > -1 && minutes < 61)
                {
                    date = new DateTime(sessionDate.SelectedDate.Value.Year, sessionDate.SelectedDate.Value.Month, sessionDate.SelectedDate.Value.Day, hours, minutes, 0);
                    DateTime nowDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second);
                    if (nowDate > date)
                    {
                        dateAllert.Visibility = Visibility.Visible;
                        dateAllert.Text = "выбранная дата уже прошла";
                        check = false;
                    }
                    session.data = date;
                    session.hour = hours;
                    session.minutes = minutes;
                }
                else {
                    dateAllert.Visibility = Visibility.Visible;
                    dateAllert.Text = "проверьте корректность введенного времени";
                    check = false;
                }
            }
            catch
            {
                dateAllert.Visibility = Visibility.Visible;
                dateAllert.Text = "Проверьте корректность введенной даты";
                check = false;
            }

            if (check)
            {
                string timeString = "";
                if (session.hour < 10) timeString = "0";
                timeString += session.hour.ToString() + ":";
                if (session.minutes < 10) timeString += "0";
                timeString += session.minutes.ToString();
                main.bd.Sessions.Add(session);
                main.bd.SaveChanges();
                Button button = new Button();
                button.Content = main.bd.Films.Find(session.film_id).name + " " + session.data.ToShortDateString() + " " + timeString;
                button.FontSize = 15;
                button.Click += SessionClick;
                button.DataContext = session;
                sessions.Children.Add(button);

                foreach (Places place in ((Halls)((ComboBoxItem)halls.SelectedItem).DataContext).Places)
                {
                    Tickets ticket = new Tickets();
                    int j = -1; bool isFind = true;
                    while (isFind)
                    {
                        j++;
                        isFind = false;
                        foreach (Tickets tickets in main.bd.Tickets)
                        {
                            if (tickets.id == j)
                                isFind = true;
                        }
                    }
                    ticket.id = j;
                    ticket.session_id = session.id;
                    ticket.place_id = place.id;
                    ticket.state = false;
                    ticket.price = price;
                    main.bd.Tickets.Add(ticket);
                    main.bd.SaveChanges();
                }
            }
            else
            {
                MessageBox.Show("Произошла ошибка");
            }
        }

        private void Cinemas_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            changeHalls();
        }
    }
}
