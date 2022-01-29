using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolDB.Models
{
    public partial class TblBetyg
    {
        public TblBetyg()
        {
            TblEleverKurser = new HashSet<TblEleverKurser>();
        }

        public string BBokstav { get; set; }
        public double? BVärde { get; set; }

        public virtual ICollection<TblEleverKurser> TblEleverKurser { get; set; }
    }
}
