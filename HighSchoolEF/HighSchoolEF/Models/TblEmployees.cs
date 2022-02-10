using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolEF.Models
{
    public partial class TblEmployees
    {
        public int EId { get; set; }
        public string EFirstName { get; set; }
        public string ELastName { get; set; }
        public string EJob { get; set; }
        public int? EYearsOfWork { get; set; }
        public double? ESalary { get; set; }

        public virtual TblTeacher TblTeacher { get; set; }
    }
}
