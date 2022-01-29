using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolDB.Models
{
    public partial class TblLärare
    {
        public TblLärare()
        {
            TblKurserPersonal = new HashSet<TblKurserPersonal>();
        }

        public double LId { get; set; }
        public double? LKlassId { get; set; }

        public virtual TblPersonal L { get; set; }
        public virtual TblKlasser LKlass { get; set; }
        public virtual ICollection<TblKurserPersonal> TblKurserPersonal { get; set; }
    }
}
