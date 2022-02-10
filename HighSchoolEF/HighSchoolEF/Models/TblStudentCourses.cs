using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolEF.Models
{
    public partial class TblStudentCourses
    {
        public int ScId { get; set; }
        public int ScStudentId { get; set; }
        public int ScCourseId { get; set; }
        public string ScGrade { get; set; }
        public string ScDate { get; set; }

        public virtual TblCourses ScCourse { get; set; }
        public virtual TblGrades ScGradeNavigation { get; set; }
        public virtual TblStudents ScStudent { get; set; }
    }
}
