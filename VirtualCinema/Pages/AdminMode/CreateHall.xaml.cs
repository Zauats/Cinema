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
    /// Логика взаимодействия для CreateHall.xaml
    /// </summary>
    public partial class CreateHall : Page
    {

        Halls hall;
        Button button;

        MainWindow main;
        public CreateHall(MainWindow main)
        {
            this.main = main;
            InitializeComponent();
            foreach (Cinemas cinema in main.bd.Cinemas)
            {
                ComboBoxItem comboBox = new ComboBoxItem();
                comboBox.Content = cinema.id + ": " + cinema.name;
                comboBox.FontSize = 15;
                comboBox.DataContext = cinema;
                cinemas.Items.Add(comboBox);
            }
            if (cinemas.Items.Count != 0)
                cinemas.SelectedIndex = 0;

            fillHalls();

        }


        private void fillHalls()
        {
            halls.Children.Clear();
            Cinemas cinema = (Cinemas)((ComboBoxItem)cinemas.SelectedValue).DataContext;
            foreach(Halls hall in cinema.Halls)
            {
                Button button = new Button();
                button.Content = hall.id + ": " + hall.name;
                button.FontSize = 15;
                button.Click += HallClick;
                button.DataContext = hall;
                halls.Children.Add(button);
            }
        }

        private void HallClick(object sender, RoutedEventArgs e)
        {
            Halls hall = (Halls)((Button)sender).DataContext;
            deleteHallButton.Visibility = Visibility.Visible;
            changeHallButton.Visibility = Visibility.Visible;
            hallName.Text = hall.name;
            rowQuantity.Text = hall.row_quantity.ToString();
            columnQuantity.Text = hall.column_quantity.ToString();
            this.hall = hall;
            this.button = (Button)sender;
            fillPlaces();
        }

        private void fillPlaces()
        {
            int row = Convert.ToInt32(rowQuantity.Text);
            int column = Convert.ToInt32(columnQuantity.Text);
            places.Children.Clear();
            places.RowDefinitions.Clear();
            places.ColumnDefinitions.Clear();

            for (int i = 0; i < row; i++)
                places.RowDefinitions.Add(new RowDefinition());
            for (int i = 0; i < column; i++)
                places.ColumnDefinitions.Add(new ColumnDefinition());

            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < column; j++)
                {
                    bool check = false;
                    foreach (Places place in this.hall.Places)
                    {
                        if (place.row_number == i && place.column_number == j)
                            check = true;
                    }

                    Rectangle rect = new Rectangle();
                    if (check)
                        rect.Fill = Brushes.White;
                    else
                    {
                        Color color = new Color();
                        color.A = 255;
                        color.R = 86;
                        color.G = 82;
                        color.B = 82;
                        rect.Fill = new SolidColorBrush(color);
                    }
                    rect.DataContext = check;
                    Grid.SetRow(rect, i);
                    Grid.SetColumn(rect, j);
                    rect.MouseDown += rectClick;
                    places.Children.Add(rect);
                    rect.Margin = new Thickness(5, 5, 5, 5);
                }
            }
        }

        private void rectClick(object sender, RoutedEventArgs e)
        {
            Rectangle rect = (Rectangle)sender;
            if ((bool)rect.DataContext)
            {
                Color color = new Color();
                color.A = 255;
                color.R = 86;
                color.G = 82;
                color.B = 82;
                rect.Fill = new SolidColorBrush(color);
                rect.DataContext = false;
            }
            else
            {
                rect.Fill = Brushes.White;
                rect.DataContext = true;
            }
        }


        private void CreateHallClick(object sender, RoutedEventArgs e)
        {
            bool check = true;
            Halls hall = new Halls();
            int i = -1; bool isFindId = true;
            while (isFindId)
            {
                i++;
                isFindId = false;
                foreach (Halls halls in main.bd.Halls)
                {
                    if (halls.id == i)
                        isFindId = true;
                }
            }
            hall.id = i;
            hall.name = hallName.Text;
            try
            {
                hall.column_quantity = Convert.ToInt32(columnQuantity.Text);
                hall.row_quantity = Convert.ToInt32(rowQuantity.Text);
            }
            catch
            {
                check = false;
            }
            hall.cinema_id = ((Cinemas)((ComboBoxItem)cinemas.SelectedValue).DataContext).id;
            if (check)
            {
                main.bd.Halls.Add(hall);
                main.bd.SaveChanges();
            }
            fillHalls();
        }

        private void ChangeHallClick(object sender, RoutedEventArgs e)
        {
            foreach (Rectangle rect in places.Children)
            {
                if ((bool)rect.DataContext)
                {
                    bool check = false;
                    foreach (Places place in hall.Places)
                    {
                        if (place.row_number == Grid.GetRow(rect) && place.column_number == Grid.GetColumn(rect))
                        {
                            check = true;
                        }
                    }

                    if (!check)
                    {
                        Places place = new Places();
                        place.column_number = Grid.GetColumn(rect);
                        place.row_number = Grid.GetRow(rect);
                        place.hall_id = hall.id;
                        int i = -1; bool isFindId = true;
                        while (isFindId)
                        {
                            i++;
                            isFindId = false;
                            foreach (Places places in main.bd.Places)
                            {
                                if (places.id == i)
                                    isFindId = true;
                            }
                        }
                        place.id = i;
                        main.bd.Places.Add(place);
                        main.bd.SaveChanges();
                    }
                }
                else
                {
                    bool check = false;
                    Places deletePlace = new Places();
                    foreach (Places place in hall.Places)
                    {
                        if (place.row_number == Grid.GetRow(rect) && place.column_number == Grid.GetColumn(rect))
                        {
                            deletePlace = place;
                            check = true;
                        }
                    }
                    if (check)
                        main.bd.Places.Remove(deletePlace);
                }
            }

            hall.name = hallName.Text;
            button.Content = hall.id.ToString() + ": " + hall.name;
            hall.cinema_id = ((Cinemas)((ComboBoxItem)cinemas.SelectedItem).DataContext).id;
            main.bd.SaveChanges();
        }

        private void DeleteHallClick(object sender, RoutedEventArgs e)
        {
            main.bd.Halls.Remove(hall);
            halls.Children.Remove(button);
            deleteHallButton.Visibility = Visibility.Hidden;
            changeHallButton.Visibility = Visibility.Hidden;
            main.bd.SaveChanges();

        }

        private void Cinemas_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            fillHalls();
        }
    }
}
