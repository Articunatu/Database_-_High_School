using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolEF.Models
{
    public partial class TblTeacher
    {
        public TblTeacher()
        {
            TblTeacherCourses = new HashSet<TblTeacherCourses>();
        }

        public double TId { get; set; }
        public double? TClassId { get; set; }
        public int TDepartmentId { get; set; }

        public virtual TblEmployees T { get; set; }
        public virtual TblClasses TClass { get; set; }
        public virtual TblDepartment TDepartment { get; set; }
        public virtual ICollection<TblTeacherCourses> TblTeacherCourses { get; set; }
    }
}
