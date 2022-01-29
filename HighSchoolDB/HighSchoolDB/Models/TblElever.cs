using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolDB.Models
{
    public partial class TblElever
    {
        public TblElever()
        {
            TblEleverKurser = new HashSet<TblEleverKurser>();
        }

        public double EId { get; set; }
        public string EFörnamn { get; set; }
        public string EEfternamn { get; set; }
        public string EPersonnummer { get; set; }
        public double? EKlassId { get; set; }

        public virtual TblKlasser EKlass { get; set; }
        public virtual ICollection<TblEleverKurser> TblEleverKurser { get; set; }
    }
}
