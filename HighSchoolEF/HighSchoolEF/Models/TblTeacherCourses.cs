using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolEF.Models
{
    public partial class TblTeacherCourses
    {
        public int TcId { get; set; }
        public int TcCourseId { get; set; }
        public int TcIsGrader { get; set; }
        public int TcTeacherId { get; set; }

        public virtual TblCourses TcCourse { get; set; }
        public virtual TblTeacher TcTeacher { get; set; }
    }
}
