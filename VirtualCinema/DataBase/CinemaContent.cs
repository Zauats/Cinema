namespace VirtualCinema.DataBase
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class CinemaContent : DbContext
    {
        public CinemaContent()
            : base("name=CinemaContent3")
        {
        }

        public virtual DbSet<Cinemas> Cinemas { get; set; }
        public virtual DbSet<Films> Films { get; set; }
        public virtual DbSet<Halls> Halls { get; set; }
        public virtual DbSet<Places> Places { get; set; }
        public virtual DbSet<Session_types> Session_types { get; set; }
        public virtual DbSet<Sessions> Sessions { get; set; }
        public virtual DbSet<sysdiagrams> sysdiagrams { get; set; }
        public virtual DbSet<Tickets> Tickets { get; set; }
        public virtual DbSet<Users> Users { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Cinemas>()
                .HasMany(e => e.Halls)
                .WithRequired(e => e.Cinemas)
                .HasForeignKey(e => e.cinema_id)
                .WillCascadeOnDelete(true);

            modelBuilder.Entity<Films>()
                .HasMany(e => e.Sessions)
                .WithRequired(e => e.Films)
                .HasForeignKey(e => e.film_id)
                .WillCascadeOnDelete(true);

            modelBuilder.Entity<Halls>()
                .Property(e => e.name)
                .IsUnicode(false);

            modelBuilder.Entity<Halls>()
                .HasMany(e => e.Places)
                .WithRequired(e => e.Halls)
                .HasForeignKey(e => e.hall_id)
                .WillCascadeOnDelete(true);

            modelBuilder.Entity<Halls>()
                .HasMany(e => e.Sessions)
                .WithRequired(e => e.Halls)
                .HasForeignKey(e => e.hall_id)
                .WillCascadeOnDelete(true);

            modelBuilder.Entity<Places>()
                .HasMany(e => e.Tickets)
                .WithRequired(e => e.Places)
                .HasForeignKey(e => e.place_id)
                .WillCascadeOnDelete(true);

            modelBuilder.Entity<Session_types>()
                .HasMany(e => e.Sessions)
                .WithRequired(e => e.Session_types)
                .HasForeignKey(e => e.session_type)
                .WillCascadeOnDelete(true);

            modelBuilder.Entity<Sessions>()
                .HasMany(e => e.Tickets)
                .WithRequired(e => e.Sessions)
                .HasForeignKey(e => e.session_id)
                .WillCascadeOnDelete(true);

            modelBuilder.Entity<Users>()
                .HasMany(e => e.Tickets)
                .WithOptional(e => e.Users)
                .HasForeignKey(e => e.user_id);
        }
    }
}
