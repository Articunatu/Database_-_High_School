using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolEF.Models
{
    public partial class SampleDbContext : DbContext
    {
        public SampleDbContext()
        {
        }

        public SampleDbContext(DbContextOptions<SampleDbContext> options)
            : base(options)
        {
        }

        public virtual DbSet<TblClasses> TblClasses { get; set; }
        public virtual DbSet<TblCourses> TblCourses { get; set; }
        public virtual DbSet<TblDepartment> TblDepartment { get; set; }
        public virtual DbSet<TblEmployees> TblEmployees { get; set; }
        public virtual DbSet<TblGrades> TblGrades { get; set; }
        public virtual DbSet<TblStudentCourses> TblStudentCourses { get; set; }
        public virtual DbSet<TblStudents> TblStudents { get; set; }
        public virtual DbSet<TblTeacher> TblTeacher { get; set; }
        public virtual DbSet<TblTeacherCourses> TblTeacherCourses { get; set; }
        public virtual DbSet<VwEmployeesInfo> VwEmployeesInfo { get; set; }
        public virtual DbSet<VwGradeStatistics> VwGradeStatistics { get; set; }
        public virtual DbSet<VwMonthlyGrades> VwMonthlyGrades { get; set; }
        public virtual DbSet<VwStaffAvgSalary> VwStaffAvgSalary { get; set; }
        public virtual DbSet<VwValueStatistics> VwValueStatistics { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer("Data Source=LAPTOP-PUKB477F;Initial Catalog=HighSchoolDB;Integrated Security=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<TblClasses>(entity =>
            {
                entity.HasKey(e => e.ClId)
                    .HasName("PK_tblKlasser");

                entity.ToTable("tblClasses");

                entity.Property(e => e.ClId).HasColumnName("Cl_ID");

                entity.Property(e => e.ClName)
                    .HasColumnName("Cl_Name")
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<TblCourses>(entity =>
            {
                entity.HasKey(e => e.CId)
                    .HasName("PK_tblKurser");

                entity.ToTable("tblCourses");

                entity.Property(e => e.CId).HasColumnName("C_ID");

                entity.Property(e => e.CName)
                    .IsRequired()
                    .HasColumnName("C_Name")
                    .HasMaxLength(255);

                entity.Property(e => e.CPoints).HasColumnName("C_Points");
            });

            modelBuilder.Entity<TblDepartment>(entity =>
            {
                entity.HasKey(e => e.DId);

                entity.ToTable("tblDepartment");

                entity.Property(e => e.DId)
                    .HasColumnName("D_ID")
                    .ValueGeneratedNever();

                entity.Property(e => e.DName)
                    .IsRequired()
                    .HasColumnName("D_Name")
                    .HasMaxLength(20)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<TblEmployees>(entity =>
            {
                entity.HasKey(e => e.EId)
                    .HasName("PK_tblPersonal_");

                entity.ToTable("tblEmployees");

                entity.Property(e => e.EId).HasColumnName("E_ID");

                entity.Property(e => e.EFirstName)
                    .HasColumnName("E_FirstName")
                    .HasMaxLength(255);

                entity.Property(e => e.EJob)
                    .HasColumnName("E_Job")
                    .HasMaxLength(255);

                entity.Property(e => e.ELastName)
                    .HasColumnName("E_LastName")
                    .HasMaxLength(255);

                entity.Property(e => e.ESalary)
                    .HasColumnName("E_Salary")
                    .HasColumnType("decimal(18, 0)");

                entity.Property(e => e.EYearsOfWork).HasColumnName("E_YearsOfWork");
            });

            modelBuilder.Entity<TblGrades>(entity =>
            {
                entity.HasKey(e => e.GLetter)
                    .HasName("PK_tblBetyg");

                entity.ToTable("tblGrades");

                entity.Property(e => e.GLetter)
                    .HasColumnName("G_Letter")
                    .HasMaxLength(255);

                entity.Property(e => e.GValue).HasColumnName("G_Value");
            });

            modelBuilder.Entity<TblStudentCourses>(entity =>
            {
                entity.HasKey(e => e.ScId)
                    .HasName("PK_tblEleverKurser");

                entity.ToTable("tblStudentCourses");

                entity.Property(e => e.ScId).HasColumnName("SC_ID");

                entity.Property(e => e.ScCourseId).HasColumnName("SC_CourseID");

                entity.Property(e => e.ScDate)
                    .HasColumnName("SC_Date")
                    .HasMaxLength(255);

                entity.Property(e => e.ScGrade)
                    .HasColumnName("SC_Grade")
                    .HasMaxLength(255);

                entity.Property(e => e.ScStudentId).HasColumnName("SC_StudentID");

                entity.HasOne(d => d.ScCourse)
                    .WithMany(p => p.TblStudentCourses)
                    .HasForeignKey(d => d.ScCourseId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_tblEleverKurser_tblKurser");

                entity.HasOne(d => d.ScGradeNavigation)
                    .WithMany(p => p.TblStudentCourses)
                    .HasForeignKey(d => d.ScGrade)
                    .HasConstraintName("FK_EK_Betyg");

                entity.HasOne(d => d.ScStudent)
                    .WithMany(p => p.TblStudentCourses)
                    .HasForeignKey(d => d.ScStudentId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_tblEleverKurser_tblElever");
            });

            modelBuilder.Entity<TblStudents>(entity =>
            {
                entity.HasKey(e => e.SId)
                    .HasName("PK_tblElever");

                entity.ToTable("tblStudents");

                entity.Property(e => e.SId).HasColumnName("S_ID");

                entity.Property(e => e.SClassId).HasColumnName("S_ClassID");

                entity.Property(e => e.SFirstName)
                    .HasColumnName("S_FirstName")
                    .HasMaxLength(255);

                entity.Property(e => e.SLastName)
                    .HasColumnName("S_LastName")
                    .HasMaxLength(255);

                entity.Property(e => e.SSecurityNumber)
                    .IsRequired()
                    .HasColumnName("S_SecurityNumber")
                    .HasMaxLength(255);

                entity.HasOne(d => d.SClass)
                    .WithMany(p => p.TblStudents)
                    .HasForeignKey(d => d.SClassId)
                    .HasConstraintName("FK_tblElever_tblKlasser");
            });

            modelBuilder.Entity<TblTeacher>(entity =>
            {
                entity.HasKey(e => e.TId)
                    .HasName("PK_tblLärare");

                entity.ToTable("tblTeacher");

                entity.Property(e => e.TId).HasColumnName("T_ID");

                entity.Property(e => e.TClassId).HasColumnName("T_ClassID");

                entity.Property(e => e.TDepartmentId).HasColumnName("T_DepartmentID");

                entity.HasOne(d => d.TClass)
                    .WithMany(p => p.TblTeacher)
                    .HasForeignKey(d => d.TClassId)
                    .HasConstraintName("FK_tblLärare_tblKlasser");

                entity.HasOne(d => d.TDepartment)
                    .WithMany(p => p.TblTeacher)
                    .HasForeignKey(d => d.TDepartmentId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_tblTeacher_tblDepartment");

                entity.HasOne(d => d.T)
                    .WithOne(p => p.TblTeacher)
                    .HasForeignKey<TblTeacher>(d => d.TId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_tblLärare_tblPersonal_");
            });

            modelBuilder.Entity<TblTeacherCourses>(entity =>
            {
                entity.HasKey(e => e.TcId)
                    .HasName("PK_tblKurserPersonal");

                entity.ToTable("tblTeacherCourses");

                entity.Property(e => e.TcId).HasColumnName("TC_ID");

                entity.Property(e => e.TcCourseId).HasColumnName("TC_CourseID");

                entity.Property(e => e.TcIsGrader).HasColumnName("TC_IsGrader");

                entity.Property(e => e.TcTeacherId).HasColumnName("TC_TeacherID");

                entity.HasOne(d => d.TcCourse)
                    .WithMany(p => p.TblTeacherCourses)
                    .HasForeignKey(d => d.TcCourseId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_tblKurserPersonal_tblKurser");

                entity.HasOne(d => d.TcTeacher)
                    .WithMany(p => p.TblTeacherCourses)
                    .HasForeignKey(d => d.TcTeacherId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_tblKurserPersonal_tblLärare");
            });

            modelBuilder.Entity<VwEmployeesInfo>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("vwEmployeesInfo");

                entity.Property(e => e.Arbete).HasMaxLength(255);

                entity.Property(e => e.Personal).HasMaxLength(511);

                entity.Property(e => e.ÅrPåSkolan).HasColumnName("År på skolan");
            });

            modelBuilder.Entity<VwGradeStatistics>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("vwGradeStatistics");

                entity.Property(e => e.HögstaBetyg)
                    .IsRequired()
                    .HasColumnName("Högsta betyg")
                    .HasMaxLength(1)
                    .IsUnicode(false);

                entity.Property(e => e.Kurs)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.LägstaBetyg)
                    .IsRequired()
                    .HasColumnName("Lägsta betyg")
                    .HasMaxLength(1)
                    .IsUnicode(false);

                entity.Property(e => e.Medelbetyg)
                    .IsRequired()
                    .HasMaxLength(2)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<VwMonthlyGrades>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("vwMonthlyGrades");

                entity.Property(e => e.Betyg)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.Datum).HasMaxLength(255);

                entity.Property(e => e.Elev).HasMaxLength(511);

                entity.Property(e => e.Kurs)
                    .IsRequired()
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<VwStaffAvgSalary>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("vwStaffAvgSalary");

                entity.Property(e => e.Avdelning)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Medellön).HasColumnType("decimal(38, 6)");
            });

            modelBuilder.Entity<VwValueStatistics>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("vwValueStatistics");

                entity.Property(e => e.HögstaBetyg).HasColumnName("Högsta betyg");

                entity.Property(e => e.Kurs)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.LägstaBetyg).HasColumnName("Lägsta betyg");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
