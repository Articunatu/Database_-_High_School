using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolDB.Models
{
    public partial class TblKlasser
    {
        public TblKlasser()
        {
            TblElever = new HashSet<TblElever>();
            TblLärare = new HashSet<TblLärare>();
        }

        public double KlId { get; set; }
        public string KlKlassNamn { get; set; }

        public virtual ICollection<TblElever> TblElever { get; set; }
        public virtual ICollection<TblLärare> TblLärare { get; set; }
    }
}
