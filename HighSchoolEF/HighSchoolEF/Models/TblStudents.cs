using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolEF.Models
{
    public partial class TblStudents
    {
        public TblStudents()
        {
            TblStudentCourses = new HashSet<TblStudentCourses>();
        }

        public double SId { get; set; }
        public string SFirstName { get; set; }
        public string SLastName { get; set; }
        public string SSecurityNumber { get; set; }
        public double? SClassId { get; set; }

        public virtual TblClasses SClass { get; set; }
        public virtual ICollection<TblStudentCourses> TblStudentCourses { get; set; }
    }
}
