using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolDB.Models
{
    public partial class TblKurser
    {
        public TblKurser()
        {
            TblEleverKurser = new HashSet<TblEleverKurser>();
            TblKurserPersonal = new HashSet<TblKurserPersonal>();
        }

        public double KId { get; set; }
        public string KNamn { get; set; }
        public int? KPoäng { get; set; }

        public virtual ICollection<TblEleverKurser> TblEleverKurser { get; set; }
        public virtual ICollection<TblKurserPersonal> TblKurserPersonal { get; set; }
    }
}
