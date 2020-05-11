namespace VirtualCinema.DataBase
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Tickets
    {
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int id { get; set; }

        public int session_id { get; set; }

        public int place_id { get; set; }

        public bool state { get; set; }

        public double price { get; set; }

        public int? user_id { get; set; }

        public virtual Places Places { get; set; }

        public virtual Sessions Sessions { get; set; }

        public virtual Users Users { get; set; }
    }
}
