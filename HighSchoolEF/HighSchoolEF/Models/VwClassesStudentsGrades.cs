using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolEF.Models
{
    public partial class VwClassesStudentsGrades
    {
        public string Elev { get; set; }
        public string Klass { get; set; }
        public string Kurs { get; set; }
        public string Betyg { get; set; }
        public string Lärare { get; set; }
        public string Datum { get; set; }
    }
}
