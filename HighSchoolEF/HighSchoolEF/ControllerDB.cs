using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using HighSchoolEF.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace HighSchoolDB
{
    internal class ControllerDB
    {
        static void Main()
        {
            Start();
        }

        static SampleDbContext context = new SampleDbContext();
        static int countStaff = 1, countCourseTeachers = 1;

        static void Start()
        {
            Console.WriteLine("Välkommen till gymnasiets databas.\n");
            Menu();
        }

        static void Menu()
        {
            Console.WriteLine("Meny:");
            Console.WriteLine("\t 1. Se personal"); ///SQL
            Console.WriteLine("\t 2. Se elever"); ///VS
            Console.WriteLine("\t 3. Elever för varje klass"); ///VS
            Console.WriteLine("\t 4. Betyg som sats senaste månaden"); ///SQL
            Console.WriteLine("\t 5. Betygsstatistik för varje kurs"); ///SQL
            Console.WriteLine("\t 6. Lägga till elever"); ///SQL
            Console.WriteLine("\t 7. Lägga till personal"); ///VS

            Console.WriteLine("\n\t 8. Info om personal"); ///SQL
            Console.WriteLine("\t 9. Info om en elevs betyg"); ///SQL
            Console.WriteLine("\t10. Antal personer per arbetsroll"); ///VS
            Console.WriteLine("\t11. Information om alla elever"); ///VS
            Console.WriteLine("\t12. Aktiva kurser"); ///VS
            Console.WriteLine("\t13. Medellön per avdelning"); ///SQL
            Console.WriteLine("\t14. Total utbetalning per avdelning"); ///SQL
            Console.WriteLine("\t15. All info om en elev"); ///SQL
            Console.WriteLine("\t16. Sätta betyg på en elev"); ///SQL
            Console.WriteLine("\t16. Korrigera en elevs info"); ///EF

            int choice = Input();
            switch (choice)
            {
                case 1: ViewStaff(); break;
                case 2: ViewStudents(); break;
                case 3: StudentsEachClass(); break;
                case 4: ThisMonthsGrades(); break;
                case 5: GradeStatisticsEachCourse(); break;
                case 6: AddStudents(); break;
                case 7: AddStaff(); break;

                case 8: StaffInfo(); break;
                case 9: StudentsCourses(); break;
                case 10: AmountOfStaff(); break;
                case 11: EveryStudentInfo(); break;
                case 12: ActiveCourses(); break;
                case 13: MonthlySalaries(); break;
                case 14: DepartmentPay(); break;
                case 15: OneStudentsInfo(); break;
                case 16: GradeOneStudent(); break;
                case 17: UpdateStudentInfo(); break;
                default: Console.WriteLine("Välj ett giltigt alternativ!\n"); LoadingMenu(); break;
            }
        }

        static void LoadingMenu()
        {
            Console.ReadKey();
            Console.Clear();

            Menu();
        }

        static int Input()
        {
            int input = 0;
            bool isException;
            do
            {
                try
                {
                    input = int.Parse(Console.ReadLine());
                    isException = false;
                }
                catch
                {
                    Console.Write("Ogiltigt format!\n Skriv en ny siffra: ");
                    isException = true;
                }
            }
            while (isException);
            return input;
        }

        static void ViewStaff()
        {
            Console.WriteLine("PERSONAL:\n");
            Console.Write("Vill du se all personal?\nSkriv då ja: ");
            string answer = Console.ReadLine();
            if (answer == "ja")
            {
                ///Call view for all staff
                List<TblEmployees> chooseStaff = context.TblEmployees.FromSqlRaw($"EXEC spChosenStaff Inget").ToList();
                Console.WriteLine();
                foreach (var item in chooseStaff)
                {
                    Console.WriteLine("Namn: " + item.EFirstName + " " + item.ELastName);
                    Console.WriteLine("Arbete: " + item.EJob + "\n");
                }
            }
            else
            {
                Console.Write("Skriv vilket arbete personalen ska ha: ");
                string chosenWork = Console.ReadLine();
                Console.WriteLine();
                //var query = context.Database.ExecuteSqlRaw("EXEC spUtvaldPersonal @ValdKategori",
                //new SqlParameter("@ValdKategori", chosenWork));
                ///Call proc with 
                List<TblEmployees> chooseStaff = context.TblEmployees.FromSqlRaw($"EXEC spChosenStaff {chosenWork}").ToList();
                foreach (var item in chooseStaff)
                {
                    Console.WriteLine("Namn: " + item.EFirstName + " " + item.ELastName);
                    Console.WriteLine("Arbete: " + item.EJob + "\n");
                }
            }
            LoadingMenu();
        }

        static void ViewStudents()
        {
            Console.WriteLine("ELEVER:");
            IOrderedQueryable<TblStudents> students;
            Console.Write("Ska eleverna sorteras enligt efternamn eller förnamn? \nSvara ja för efternamn: ");
            string answer = Console.ReadLine().ToLower();
            if (answer == "ja")
            {
                Console.Write("Ska namnen sorteras stigande eller fallande. \nSvara ja för stigande: ");
                answer = Console.ReadLine().ToLower();
                if (answer == "ja")
                {
                    students = from TblStudents in context.TblStudents
                               orderby TblStudents.SLastName ascending
                               select TblStudents;
                }
                else
                {
                    students = from TblStudents in context.TblStudents
                               orderby TblStudents.SLastName descending
                               select TblStudents;
                }
            }
            else
            {
                Console.Write("Ska namnen sorteras stigande eller fallande. \nSvara ja för stigande: ");
                answer = Console.ReadLine().ToLower();
                if (answer == "ja")
                {
                    students = from TblStudents in context.TblStudents
                               orderby TblStudents.SLastName ascending
                               select TblStudents;
                }
                else
                {
                    students = from TblStudents in context.TblStudents
                               orderby TblStudents.SLastName descending
                               select TblStudents;
                }
            }

            Console.WriteLine();
            foreach (var item in students)
            {
                Console.WriteLine(item.SFirstName + " " + item.SLastName);
            }

            LoadingMenu();
        }

        static void StudentsEachClass()
        {
            Console.WriteLine("KLASSER: \n");
            var classes = from TblClasses in context.TblClasses
                          orderby TblClasses.ClId ascending
                          select TblClasses;
            foreach (var item in classes)
            {
                Console.WriteLine(item.ClId + " " + item.ClName);
            }
            Console.WriteLine("\nVilken klass vill titta på? \nSkriv in klassens id: ");
            int classID = Input();
            var chosenClass = from TblStudents in context.TblStudents
                              where TblStudents.SClassId == classID
                              orderby TblStudents.SLastName ascending
                              select TblStudents;
            Console.WriteLine();
            foreach (var item in chosenClass)
            {
                Console.WriteLine(item.SFirstName + " " + item.SLastName);
            }
            LoadingMenu();
        }

        static void ThisMonthsGrades()
        {
            Console.WriteLine("MÅNADENS BETYG:\n");
            var monthlyGrades = from VwMonthlyGrades in context.VwMonthlyGrades
                                select VwMonthlyGrades;
            foreach (var item in monthlyGrades)
            {
                Console.WriteLine(item.Elev);
                Console.WriteLine(item.Kurs);
                Console.WriteLine(item.Betyg + "\n");
            }
            LoadingMenu();
        }

        static void GradeStatisticsEachCourse()
        {
            Console.WriteLine("BETYGSSTATISTIK:\n");
            var gradeStats = from VwGradeStatistics in context.VwGradeStatistics
                             select VwGradeStatistics;
            foreach (var item in gradeStats)
            {
                Console.WriteLine("Kurs:  " + item.Kurs);
                Console.WriteLine("Medelbetyg:  " + item.Medelbetyg);
                Console.WriteLine("Högsta betyg:  " + item.HögstaBetyg);
                Console.WriteLine("Lägsta betyg:  " + item.LägstaBetyg + "\n");
            }
            LoadingMenu();
        }

        static void AddStudents()
        {
            Console.WriteLine("LÄGGA TILL ELEVER: \n");

            Console.Write("Vad är elevens id: ");
            int id = Input();
            Console.Write("Vad är elevns förnamn: ");
            string firstName = Console.ReadLine();
            Console.Write("Vad är elevns efternamn: ");
            string lastName = Console.ReadLine();
            Console.Write("Vad är elevns personnummer: ");
            string persNumb = Console.ReadLine();
            Console.Write("Vad är elevns klassid: ");
            int classId = Input();

            context.Database.ExecuteSqlRaw("EXEC spAddStudents @ElevID, @ElevFörnamn, @ElevEfternamn, @ElevPersonnummer, @ElevKlassID",
                new SqlParameter("@ElevID", id),
                new SqlParameter("@ElevFörnamn", firstName),
                new SqlParameter("@ElevEfternamn", lastName),
                new SqlParameter("@ElevPersonnummer", persNumb),
                new SqlParameter("@ElevKlassID", classId));
            Console.WriteLine("En ny elev har lagts till!");
            //var newStudent = from TblElever in context.TblEleverna
            //                 where TblElever.EId == id
            //                 select TblElever;
            //foreach (var item in newStudent)
            //{
            //    Console.WriteLine(item.EId + " " + item.EFörnamn + " " + item.EEfternamn);
            //}
            LoadingMenu();
        }

        static void AddStaff()
        {
            Console.WriteLine("LÄGGA TILL PERSONAL");
            Console.WriteLine();
            Console.Write("Förnamn: ");
            string firstName = Console.ReadLine();
            Console.Write("Efternamn: ");
            string lastName = Console.ReadLine();
            Console.WriteLine("Möjliga arbeten: Lärare, Administratör, SYV, Sjuksköterska");
            Console.Write("Arbete: ");
            string arbete = Console.ReadLine();
            var staffAmt = from TblEmployees in context.TblEmployees
                           select TblEmployees;
            int id = staffAmt.Count() + countStaff;
            countStaff++;
            TblEmployees staff = new TblEmployees()
            {
                EFirstName = firstName,
                ELastName = lastName,
                EJob = arbete,
                EId = id
            };
            context.TblEmployees.Add(staff);

            if (arbete == "Lärare")
            {
                var courses = from TblCourses in context.TblCourses
                              select TblCourses;
                Console.WriteLine("KURSER:\n");
                foreach (var item in courses)
                {
                    Console.WriteLine(item.CId + " " + item.CName);
                }
                Console.WriteLine();
                Console.WriteLine("Vilken eller vilka kurser undervisar läraren i? Svara i KursID");
                int courseID = Input();
                var teachCourseAmt = from TblTeacherCourses in context.TblTeacherCourses
                                     select TblTeacherCourses;
                int teachCourseID = teachCourseAmt.Count() + countCourseTeachers;
                countCourseTeachers++;
                TblTeacher teacher = new TblTeacher()
                {
                    TId = staff.EId
                };
                context.TblTeacher.Add(teacher);
                TblTeacherCourses teacherCourse = new TblTeacherCourses()
                {
                    TcCourseId = courseID,
                    TcTeacherId = staff.EId,
                    TcId = teachCourseID
                };
                context.TblTeacherCourses.Add(teacherCourse);
            }
            Console.WriteLine(staff.EId + " " + staff.EFirstName + " " + staff.ELastName + " ");
            context.SaveChanges();
            LoadingMenu();
        }

        static void StaffInfo()
        {
            Console.WriteLine("INFO OM PERSONAL:\n");
            var staffInfo = from VwEmployeesInfo in context.VwEmployeesInfo
                            select VwEmployeesInfo;

            foreach (var item in staffInfo)
            {
                Console.Write(item.Personal + "  ");
                Console.Write(item.Arbete + "  ");
                Console.Write(item.ÅrPåSkolan);
            }
        }

        static void StudentsCourses()
        {
            Console.WriteLine("ELEVERS AVSLUTADE KURSER OCH BETYG:\n");
            var studCours = from VwClassesStudentsGrades in context.VwClassesStudentsGrades
                            select VwClassesStudentsGrades;

            foreach (var item in studCours)
            {
                Console.WriteLine(item.Elev);
                Console.WriteLine(item.Kurs);
                Console.WriteLine(item.Betyg);
                Console.WriteLine(item.Datum + "\n");
            }
        }

        static void AmountOfStaff()
        {
            Console.WriteLine("ANTAL ANSTÄLLDA PER ARBETE:\n");

            var amtTeacher = from TblEmployees in context.TblEmployees
                             where TblEmployees.EJob == "Lärare"
                             select TblEmployees;

            var amtPrincipal = from TblEmployees in context.TblEmployees
                               where TblEmployees.EJob == "Rektor"
                               select TblEmployees;

            var amtAdmin = from TblEmployees in context.TblEmployees
                           where TblEmployees.EJob == "Administratör"
                           select TblEmployees;

            var amtNurse = from TblEmployees in context.TblEmployees
                           where TblEmployees.EJob == "Skolsköterska"
                           select TblEmployees;

            var amtSCC = from TblEmployees in context.TblEmployees
                         where TblEmployees.EJob == "SYV"
                         select TblEmployees;

            Console.WriteLine("Lärare: " + amtTeacher.Count());
            Console.WriteLine("Rektorer: " + amtPrincipal.Count());
            Console.WriteLine("Administratörer: " + amtAdmin.Count());
            Console.WriteLine("Skolsköterskor: " + amtNurse.Count());
            Console.WriteLine("Studievägledare: " + amtSCC.Count());

            LoadingMenu();
        }

        static void EveryStudentInfo()
        {
            Console.WriteLine("ALLA ELEVER:\n");
            var studentsInfo = context.TblStudents.Join(
                context.TblClasses,
                studentClasses => studentClasses.SClassId,
                classes => classes.ClId,
                (studentClasses, classes) => new {
                    Student = studentClasses.SFirstName + " " + studentClasses.SLastName,
                    Class = classes.ClName
                }
                ).ToList();


            foreach (var item in studentsInfo)
            {
                Console.WriteLine("Elev: " + item.Student);
                Console.WriteLine("Klass: " + item.Class + "\n");
            }

            LoadingMenu();
        }

        static void ActiveCourses()
        {
            Console.WriteLine("AKTIVA KURSER:\n");
            var activeCourses = context.TblStudentCourses.Join(
                context.TblCourses,
                stCou => stCou.ScCourseId,
                courses => courses.CId,
                (stCourses, courses) => new { Course = courses.CName, Grade = stCourses.ScGrade }
                ).Distinct().ToList();

            foreach (var item in activeCourses)
            {
                if (item.Grade == "-")
                {
                    Console.WriteLine(item.Course);
                }
            }

            LoadingMenu();
        }

        static void DepartmentPay()
        {
            Console.WriteLine("TOTAL UTBETALNING PER AVDELNING:\n");
            var totalPay = from VwPaymentDepartment in context.VwPaymentDepartment
                           select VwPaymentDepartment;

            foreach (var item in totalPay)
            {
                Console.Write(item.Avdelning + "\t");
                Console.WriteLine(item.Utbetalning);
            }
        }

        static void MonthlySalaries()
        {
            Console.WriteLine("MEDELLÖN PER AVDELNING:\n");
            var monthlySalaries = from VwStaffAvgSalary in context.VwStaffAvgSalary
                                  select VwStaffAvgSalary;

            foreach (var item in monthlySalaries)
            {
                Console.Write(item.Avdelning + "\t");
                Console.WriteLine(item.Medellön);
            }
        }

        static void OneStudentsInfo()
        {

        }

        static void GradeOneStudent()
        {
            //exec proc ada
        }

        static void UpdateStudentInfo()
        {

        }
    }
}

