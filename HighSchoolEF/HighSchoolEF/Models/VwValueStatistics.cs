using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolEF.Models
{
    public partial class VwValueStatistics
    {
        public string Kurs { get; set; }
        public double? Medelbetyg { get; set; }
        public double? LägstaBetyg { get; set; }
        public double? HögstaBetyg { get; set; }
    }
}
