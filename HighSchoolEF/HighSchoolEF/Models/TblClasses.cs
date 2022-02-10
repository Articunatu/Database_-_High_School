using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolEF.Models
{
    public partial class TblClasses
    {
        public TblClasses()
        {
            TblStudents = new HashSet<TblStudents>();
            TblTeacher = new HashSet<TblTeacher>();
        }

        public double ClId { get; set; }
        public string ClName { get; set; }

        public virtual ICollection<TblStudents> TblStudents { get; set; }
        public virtual ICollection<TblTeacher> TblTeacher { get; set; }
    }
}
