using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using HighSchoolDB.Models;
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
            Console.WriteLine("\t1. Se personal"); ///SQL
            Console.WriteLine("\t2. Se elever"); ///VS
            Console.WriteLine("\t3. Elever för varje klass"); ///VS
            Console.WriteLine("\t4. Betyg som sats senaste månaden"); ///SQL
            Console.WriteLine("\t5. Betygsstatistik för varje kurs"); ///SQL
            Console.WriteLine("\t6. Lägga till elever"); ///SQL
            Console.WriteLine("\t7. Lägga till personal"); ///VS

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
                default: ViewStaff(); break;
            }
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
                List<TblPersonal> chooseStaff = context.TblPersonalen.FromSqlRaw($"EXEC spUtvaldPersonal Inget").ToList();
                Console.WriteLine();
                foreach (var item in chooseStaff)
                {
                    Console.WriteLine("Namn: " + item.PFörnamn + " " + item.PEfternamn);
                    Console.WriteLine("Arbete: " + item.PArbete + "\n");
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
                List<TblPersonal> chooseStaff = context.TblPersonalen.FromSqlRaw($"EXEC spUtvaldPersonal {chosenWork}").ToList();
                foreach (var item in chooseStaff)
                {
                    Console.WriteLine("Namn: " + item.PFörnamn + " " + item.PEfternamn);
                    Console.WriteLine("Arbete: " + item.PArbete + "\n");
                }
            }
            LoadingMenu();
        }

        static void ViewStudents()
        {
            Console.WriteLine("ELEVER:");
            IOrderedQueryable<TblElever> students;
            Console.Write("Ska eleverna sorteras enligt efternamn eller förnamn? \nSvara ja för efternamn: ");
            string answer = Console.ReadLine().ToLower();
            if (answer == "ja")
            {
                Console.Write("Ska namnen sorteras stigande eller fallande. \nSvara ja för stigande: ");
                answer = Console.ReadLine().ToLower();
                if (answer == "ja")
                {
                    students = from TblElever in context.TblEleverna
                               orderby TblElever.EEfternamn ascending
                               select TblElever;
                }
                else
                {
                    students = from TblElever in context.TblEleverna
                               orderby TblElever.EEfternamn descending
                               select TblElever;
                }
            }
            else
            {
                Console.Write("Ska namnen sorteras stigande eller fallande. \nSvara ja för stigande: ");
                answer = Console.ReadLine().ToLower();
                if (answer == "ja")
                {
                    students = from TblElever in context.TblEleverna
                               orderby TblElever.EFörnamn ascending
                               select TblElever;
                }
                else
                {
                    students = from TblElever in context.TblEleverna
                               orderby TblElever.EFörnamn descending
                               select TblElever;
                }
            }

            Console.WriteLine();
            foreach (var item in students)
            {
                Console.WriteLine(item.EFörnamn + " " + item.EEfternamn);
            }

            LoadingMenu();
        }

        static void StudentsEachClass()
        {
            Console.WriteLine("KLASSER: \n");
            var classes = from TblKlasser in context.TblKlasserna
                          orderby TblKlasser.KlId ascending
                          select TblKlasser;
            foreach (var item in classes)
            {
                Console.WriteLine(item.KlId + " " + item.KlKlassNamn);
            }
            Console.WriteLine("\nVilken klass vill titta på? \nSkriv in klassens id: ");
            int classID = Input();
            var chosenClass = from TblElever in context.TblEleverna
                              where TblElever.EKlassId == classID
                              orderby TblElever.EEfternamn ascending
                              select TblElever;
            Console.WriteLine();
            foreach (var item in chosenClass)
            {
                Console.WriteLine(item.EFörnamn + " " + item.EEfternamn);
            }
            LoadingMenu();
        }

        static void ThisMonthsGrades()
        {
            Console.WriteLine("MÅNADENS BETYG:\n");
            var monthlyGrades = from VwMånadensBetyg in context.VwMånadensBetyg
                                select VwMånadensBetyg;
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
            var gradeStats = from VwBetygStatistik in context.VwBetygStatistik
                             select VwBetygStatistik;
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

            Console.Write("Vad är elevns id: ");
            int id = Input();
            Console.Write("Vad är elevns förnamn: ");
            string firstName = Console.ReadLine();
            Console.Write("Vad är elevns efternamn: ");
            string lastName = Console.ReadLine();
            Console.Write("Vad är elevns personnummer: ");
            string persNumb = Console.ReadLine();
            Console.Write("Vad är elevns klassid: ");
            int classId = Input();

            context.Database.ExecuteSqlRaw("EXEC spSkapaElever @ElevID, @ElevFörnamn, @ElevEfternamn, @ElevPersonnummer, @ElevKlassID",
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
            var staffAmt = from TblPersonal in context.TblPersonalen
                           select TblPersonal;
            int id = staffAmt.Count() + countStaff;
            countStaff++;
            TblPersonal staff = new TblPersonal()
            {
                PFörnamn = firstName,
                PEfternamn = lastName,
                PArbete = arbete,
                PId = id
            };
            context.TblPersonalen.Add(staff);

            if (arbete == "Lärare")
            {
                var courses = from TblKurser in context.TblKurserna
                              select TblKurser;
                Console.WriteLine("KURSER:\n");
                foreach (var item in courses)
                {
                    Console.WriteLine(item.KId + " " + item.KNamn);
                }
                Console.WriteLine();
                Console.WriteLine("Vilken eller vilka kurser undervisar läraren i? Svara i KursID");
                int courseID = Input();
                var teachCourseAmt = from TblKurserPersonal in context.TblKurserPersonalen
                                     select TblKurserPersonal;
                int teachCourseID = teachCourseAmt.Count() + countCourseTeachers;
                countCourseTeachers++;
                TblLärare teacher = new TblLärare()
                {
                    LId = staff.PId
                };
                context.TblLärarna.Add(teacher);
                TblKurserPersonal teacherCourse = new TblKurserPersonal()
                {
                    KpKursId = courseID,
                    KpPersonalId = staff.PId,
                    KpId = teachCourseID
                };
                context.TblKurserPersonalen.Add(teacherCourse);
            }
            Console.WriteLine(staff.PId + " " + staff.PFörnamn + " " + staff.PEfternamn + " ");
            context.SaveChanges();
            LoadingMenu();
        }

        static void LoadingMenu()
        {
            Console.ReadKey();
            Console.Clear();

            Menu();
        }
    }
}