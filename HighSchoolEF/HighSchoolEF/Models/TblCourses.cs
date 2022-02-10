using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolEF.Models
{
    public partial class TblCourses
    {
        public TblCourses()
        {
            TblStudentCourses = new HashSet<TblStudentCourses>();
            TblTeacherCourses = new HashSet<TblTeacherCourses>();
        }

        public int CId { get; set; }
        public string CName { get; set; }
        public int CPoints { get; set; }

        public virtual ICollection<TblStudentCourses> TblStudentCourses { get; set; }
        public virtual ICollection<TblTeacherCourses> TblTeacherCourses { get; set; }
    }
}
