using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolDB.Models
{
    public partial class TblKurserPersonal
    {
        public double KpId { get; set; }
        public double? KpKursId { get; set; }
        public double? KpPersonalId { get; set; }

        public virtual TblKurser KpKurs { get; set; }
        public virtual TblLärare KpPersonal { get; set; }
    }
}
