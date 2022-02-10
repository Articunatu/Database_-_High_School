using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolEF.Models
{
    public partial class TblDepartment
    {
        public TblDepartment()
        {
            TblTeacher = new HashSet<TblTeacher>();
        }

        public int DId { get; set; }
        public string DName { get; set; }

        public virtual ICollection<TblTeacher> TblTeacher { get; set; }
    }
}
