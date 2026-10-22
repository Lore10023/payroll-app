# Payroll App

ASP.NET Web Forms (C#) application for managing employees and computing salaries, using Oracle as the database and Crystal Reports for printable documents.

## Features

- **Master page layout**: header, navigation menu, content area.
- **Header (AJAX)**: live server clock and date, plus randomly rotating advertisement images.
- **Home**: global help and usage instructions.
- **Update data**: search for an employee by name, or edit all employees in a grid. Editable fields: `NUME`, `PRENUME`, `SALAR_BAZA`, `SPOR_%`, `PREMII_BRUTE`, `RETINERI`.
- **Add employees**: validated input with defaults (`SPOR_% = 0`, `RETINERI = 0`). The salary is computed automatically and the form stays open for the next entry.
- **Delete employees**: search by name and/or surname, select one if several match, and confirm before deleting. A message is shown if nobody is found.
- **Salary calculation**: performed automatically by database triggers on every change to the data, with a confirmation message.
- **Payroll statement**: tabular Crystal Report for all employees, with totals for `TOTAL_BRUT` and `VIRAT_CARD`. It can be printed or exported to PDF, with the month in the file name.
- **Payslips**: report for all employees, or for a single searched employee, with printing.
- **Modify tax rates**: edit the CAS, CASS and income tax percentages. Access is protected by an encrypted password stored in the database. After a change, salaries are recalculated automatically.

## Calculation formulas

```
TOTAL_BRUT      = SALAR_BAZA * (1 + SPOR_% / 100) + PREMII_BRUTE
CAS             = TOTAL_BRUT * CAS_%
CASS            = TOTAL_BRUT * CASS_%
BRUT_IMPOZABIL  = TOTAL_BRUT - CAS - CASS
IMPOZIT         = BRUT_IMPOZABIL * IMPOZIT_%
VIRAT_CARD      = TOTAL_BRUT - IMPOZIT - CAS - CASS - RETINERI
```

Default rates: CAS 25%, CASS 10%, income tax 10%. All computed values are rounded to integers.

## Tech stack

- ASP.NET Web Forms, C#, .NET Framework
- ASP.NET AJAX (UpdatePanel, Timer)
- Oracle Database XE
- Crystal Reports (`StatPlataReport.rpt`, `FluturasReport.rpt`)

## Requirements

- Visual Studio with the ASP.NET workload
- Oracle Database XE
- Crystal Reports runtime for Visual Studio

## Setup

1. Run the SQL script in SQL*Plus before starting the app. It creates and populates the tables and triggers:
```
   sqlplus STUDENT/<password>@localhost:1521/xe @baza_de_date.sql
```
2. Copy `connections.config.example` to `connections.config` and enter your database credentials.
3. Open the solution in Visual Studio and restore the NuGet packages.
4. Make sure the `PDF` folder exists (it is used for exported payroll files).
5. Run the project. The start page is Home.

## Database

- `ANGAJATI`: employee data (editable and computed fields).
- Percentages table: CAS, CASS and income tax rates, plus the encrypted access password.
- Triggers: recompute the computed columns when an employee is inserted or updated, and recompute all salaries when the rates change.
- All operations run transactionally (all or nothing).

## Project structure

```
Site.Master               Layout: header, menu, shortcut panel
About.aspx                Home / help page
ActualizareDate.aspx      Update data
AdaugareAngajati.aspx     Add employees
StergereAngajat.aspx      Delete employees
StatPlata.aspx            Payroll statement report
FluturasiRaport.aspx      Payslips report
ModificareProcente.aspx   Tax rates (password protected)
StatPlataReport.rpt       Payroll statement report definition
FluturasReport.rpt        Payslip report definition
sql_comenzi.sql          Tables, data and triggers
```

## Notes

- Database credentials and the rates password are not stored in the repository.
- Generated PDF files are excluded through `.gitignore`.

## Author

Lore10023# payroll-app