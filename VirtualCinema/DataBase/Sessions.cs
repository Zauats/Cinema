namespace VirtualCinema.DataBase
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Sessions
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Sessions()
        {
            Tickets = new HashSet<Tickets>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int id { get; set; }

        public int hall_id { get; set; }

        [Column(TypeName = "date")]
        public DateTime data { get; set; }

        public int film_id { get; set; }

        public int session_type { get; set; }

        public int? minutes { get; set; }

        public int? hour { get; set; }

        public virtual Films Films { get; set; }

        public virtual Halls Halls { get; set; }

        public virtual Session_types Session_types { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Tickets> Tickets { get; set; }
    }
}
