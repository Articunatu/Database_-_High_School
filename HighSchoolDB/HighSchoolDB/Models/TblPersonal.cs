using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolDB.Models
{
    public partial class TblPersonal
    {
        public double PId { get; set; }
        public string PFörnamn { get; set; }
        public string PEfternamn { get; set; }
        public string PArbete { get; set; }

        public virtual TblLärare TblLärare { get; set; }
    }
}
