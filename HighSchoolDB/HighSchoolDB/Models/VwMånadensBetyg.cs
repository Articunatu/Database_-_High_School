using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolDB.Models
{
    public partial class VwMånadensBetyg
    {
        public string Elev { get; set; }
        public string Kurs { get; set; }
        public string Betyg { get; set; }
    }
}
