using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using HighSchoolDB.Models;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace HighSchoolDB.Models
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

        public virtual DbSet<MedelBetyg> MedelBetyg { get; set; }
        public virtual DbSet<TblBetyg> TblBetygen { get; set; }
        public virtual DbSet<TblElever> TblEleverna { get; set; }
        public virtual DbSet<TblEleverKurser> TblEleverKurserna { get; set; }
        public virtual DbSet<TblKlasser> TblKlasserna { get; set; }
        public virtual DbSet<TblKurser> TblKurserna { get; set; }
        public virtual DbSet<TblKurserPersonal> TblKurserPersonalen { get; set; }
        public virtual DbSet<TblLärare> TblLärarna { get; set; }
        public virtual DbSet<TblPersonal> TblPersonalen { get; set; }
        public virtual DbSet<VwBetygStatistik> VwBetygStatistik { get; set; }
        public virtual DbSet<VwMånadensBetyg> VwMånadensBetyg { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer("Data Source = ;Initial Catalog=HighSchool;Integrated Security=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<MedelBetyg>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("MedelBetyg");

                entity.Property(e => e.Medelbetyg1).HasColumnName("Medelbetyg");
            });

            modelBuilder.Entity<TblBetyg>(entity =>
            {
                entity.HasKey(e => e.BBokstav);

                entity.ToTable("tblBetyg");

                entity.Property(e => e.BBokstav)
                    .HasColumnName("B_Bokstav")
                    .HasMaxLength(255);

                entity.Property(e => e.BVärde).HasColumnName("B_Värde");
            });

            modelBuilder.Entity<TblElever>(entity =>
            {
                entity.HasKey(e => e.EId);

                entity.ToTable("tblElever");

                entity.Property(e => e.EId).HasColumnName("E_ID");

                entity.Property(e => e.EEfternamn)
                    .HasColumnName("E_Efternamn")
                    .HasMaxLength(255);

                entity.Property(e => e.EFörnamn)
                    .HasColumnName("E_Förnamn")
                    .HasMaxLength(255);

                entity.Property(e => e.EKlassId).HasColumnName("E_Klass_ID");

                entity.Property(e => e.EPersonnummer)
                    .HasColumnName("E_Personnummer")
                    .HasMaxLength(255);

                entity.HasOne(d => d.EKlass)
                    .WithMany(p => p.TblElever)
                    .HasForeignKey(d => d.EKlassId)
                    .HasConstraintName("FK_tblElever_tblKlasser");
            });

            modelBuilder.Entity<TblEleverKurser>(entity =>
            {
                entity.HasKey(e => e.EkId);

                entity.ToTable("tblEleverKurser");

                entity.Property(e => e.EkId).HasColumnName("EK_ID");

                entity.Property(e => e.EkBetyg)
                    .HasColumnName("EK_Betyg")
                    .HasMaxLength(255);

                entity.Property(e => e.EkBetygDatum)
                    .HasColumnName("EK_BetygDatum")
                    .HasMaxLength(255);

                entity.Property(e => e.EkElevId).HasColumnName("EK_ElevID");

                entity.Property(e => e.EkKursId).HasColumnName("EK_KursID");

                entity.HasOne(d => d.EkBetygNavigation)
                    .WithMany(p => p.TblEleverKurser)
                    .HasForeignKey(d => d.EkBetyg)
                    .HasConstraintName("FK_EK_Betyg");

                entity.HasOne(d => d.EkElev)
                    .WithMany(p => p.TblEleverKurser)
                    .HasForeignKey(d => d.EkElevId)
                    .HasConstraintName("FK_tblEleverKurser_tblElever");

                entity.HasOne(d => d.EkKurs)
                    .WithMany(p => p.TblEleverKurser)
                    .HasForeignKey(d => d.EkKursId)
                    .HasConstraintName("FK_tblEleverKurser_tblKurser");
            });

            modelBuilder.Entity<TblKlasser>(entity =>
            {
                entity.HasKey(e => e.KlId);

                entity.ToTable("tblKlasser");

                entity.Property(e => e.KlId).HasColumnName("Kl_ID");

                entity.Property(e => e.KlKlassNamn)
                    .HasColumnName("Kl_KlassNamn")
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<TblKurser>(entity =>
            {
                entity.HasKey(e => e.KId);

                entity.ToTable("tblKurser");

                entity.Property(e => e.KId).HasColumnName("K_ID");

                entity.Property(e => e.KNamn)
                    .IsRequired()
                    .HasColumnName("K_Namn")
                    .HasMaxLength(255);

                entity.Property(e => e.KPoäng).HasColumnName("K_Poäng");
            });

            modelBuilder.Entity<TblKurserPersonal>(entity =>
            {
                entity.HasKey(e => e.KpId);

                entity.ToTable("tblKurserPersonal");

                entity.Property(e => e.KpId).HasColumnName("KP_ID");

                entity.Property(e => e.KpKursId).HasColumnName("KP_KursID");

                entity.Property(e => e.KpPersonalId).HasColumnName("KP_PersonalID");

                entity.HasOne(d => d.KpKurs)
                    .WithMany(p => p.TblKurserPersonal)
                    .HasForeignKey(d => d.KpKursId)
                    .HasConstraintName("FK_tblKurserPersonal_tblKurser");

                entity.HasOne(d => d.KpPersonal)
                    .WithMany(p => p.TblKurserPersonal)
                    .HasForeignKey(d => d.KpPersonalId)
                    .HasConstraintName("FK_tblKurserPersonal_tblLärare");
            });

            modelBuilder.Entity<TblLärare>(entity =>
            {
                entity.HasKey(e => e.LId);

                entity.ToTable("tblLärare");

                entity.Property(e => e.LId).HasColumnName("L_ID");

                entity.Property(e => e.LKlassId).HasColumnName("L_KlassID");

                entity.HasOne(d => d.L)
                    .WithOne(p => p.TblLärare)
                    .HasForeignKey<TblLärare>(d => d.LId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_tblLärare_tblPersonal_");

                entity.HasOne(d => d.LKlass)
                    .WithMany(p => p.TblLärare)
                    .HasForeignKey(d => d.LKlassId)
                    .HasConstraintName("FK_tblLärare_tblKlasser");
            });

            modelBuilder.Entity<TblPersonal>(entity =>
            {
                entity.HasKey(e => e.PId);

                entity.ToTable("tblPersonal_");

                entity.Property(e => e.PId).HasColumnName("P_ID");

                entity.Property(e => e.PArbete)
                    .HasColumnName("P_Arbete")
                    .HasMaxLength(255);

                entity.Property(e => e.PEfternamn)
                    .HasColumnName("P_Efternamn")
                    .HasMaxLength(255);

                entity.Property(e => e.PFörnamn)
                    .HasColumnName("P_Förnamn")
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<VwBetygStatistik>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("vwBetygStatistik");

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

            modelBuilder.Entity<VwMånadensBetyg>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("vwMånadensBetyg");

                entity.Property(e => e.Betyg)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.Elev).HasMaxLength(511);

                entity.Property(e => e.Kurs)
                    .IsRequired()
                    .HasMaxLength(255);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
