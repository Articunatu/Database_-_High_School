using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolDB.Models
{
    public partial class TblEleverKurser
    {
        public double EkId { get; set; }
        public double EkElevId { get; set; }
        public double EkKursId { get; set; }
        public string EkBetyg { get; set; }
        public string EkBetygDatum { get; set; }

        public virtual TblBetyg EkBetygNavigation { get; set; }
        public virtual TblElever EkElev { get; set; }
        public virtual TblKurser EkKurs { get; set; }
    }
}
