<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Salarizare.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .hero { background: linear-gradient(135deg, #003399 0%, #0077cc 55%, #00b4d8 100%); color: #fff;
                padding: 28px 32px; border-radius: 14px; margin: 15px 0 22px; box-shadow: 0 6px 18px rgba(0,51,153,.3); }
        .hero h2 { margin: 0; font-size: 50px; font-weight: bold; color: #fff; }
        .hero h3 { margin: 8px 0 4px; font-weight: 400; color: #e6f4ff; }
        .hero p { margin: 0; color: #e6f4ff; }

        .card { --c: #003399; --bg: #eef2ff; border: 2px solid var(--c); border-radius: 10px; margin-bottom: 16px; background: var(--bg); overflow: hidden; }
        .card h4 { margin: 0; padding: 12px 18px; font-size: 19px; font-weight: 700; color: #fff; background: var(--c); }
        .card .corp { padding: 14px 20px; line-height: 1.6; }

        .c1 { --c: #0057b8; --bg: #e8f1fd; }
        .c2 { --c: #7b3fe4; --bg: #f1eafd; }
        .c3 { --c: #2e9e4f; --bg: #e9f8ee; }
        .c4 { --c: #e0453a; --bg: #fdecea; }
        .c5 { --c: #f08c00; --bg: #fff4e0; }
        .c6 { --c: #0aa5a5; --bg: #e3f7f7; }
        .c7 { --c: #d6336c; --bg: #fde8f0; }
        .c8 { --c: #5c6bc0; --bg: #ebedf9; }

        .pasi { counter-reset: pas; list-style: none; padding: 0; margin: 0; }
        .pasi li { counter-increment: pas; margin: 10px 0; padding-left: 46px; position: relative; }
        .pasi li::before { content: counter(pas); position: absolute; left: 0; top: -3px; width: 32px; height: 32px; line-height: 32px;
                           text-align: center; border-radius: 50%; color: #fff; font-weight: bold; background: #f08c00; }
        .pasi li:nth-child(2)::before { background: #2e9e4f; }
        .pasi li:nth-child(3)::before { background: #7b3fe4; }
        .pasi li:nth-child(4)::before { background: #0aa5a5; }
        .pasi li:nth-child(5)::before { background: #d6336c; }

        .camp { display: inline-block; background: #fff; border: 1px solid var(--c); color: var(--c); border-radius: 12px; padding: 1px 9px; margin: 2px 2px; font-size: 14px; font-weight: 600; }
        .nota { margin-top: 10px; padding: 8px 12px; background: #fff; border-left: 5px solid var(--c); border-radius: 4px; }
    </style>

    <main aria-labelledby="title">
        <div class="hero">
            <h2 id="title">Home Page</h2>
            <h3>Ajutor privind modul de operare al aplicației Salarizare</h3>
            <p>Aplicația gestionează angajații, calculează salariile și generează statul de plată și fluturașii.
               Utilizați meniul de sus pentru a alege operația dorită.</p>
        </div>

        <div class="card c8">
            <h4>🧭 Ordinea recomandată de lucru</h4>
            <div class="corp">
                <ol class="pasi">
                    <li>Adăugați angajații noi (salariul se calculează automat).</li>
                    <li>Actualizați datele variabile: SPOR_%, PREMII_BRUTE, RETINERI.</li>
                    <li>Dacă s-au schimbat procentele, modificați-le în MODIFICARE IMPOZIT. Salariile se recalculează automat prin trigger.</li>
                    <li>Afișați Statul de plată și salvați-l în PDF cu numele lunii.</li>
                    <li>Listați fluturașii, pentru toți angajații sau doar pentru unul.</li>
                </ol>
            </div>
        </div>

        <div class="card c1">
            <h4>✏️ Actualizare date</h4>
            <div class="corp">
                Căutați un angajat după nume și modificați doar câmpurile editabile:
                <span class="camp">NUME</span><span class="camp">SALAR_BAZA</span><span class="camp">SPOR_%</span><span class="camp">PREMII_BRUTE</span><span class="camp">RETINERI</span><br />
                Puteți actualiza și mai mulți angajați, deplasându-vă pe fiecare înregistrare din tabelul cu toate datele
                (de exemplu, pentru a acorda o primă diferită fiecărui angajat).
                <div class="nota">Deoarece numărul de angajați poate depăși 1000, folosiți opțiunea de căutare.</div>
            </div>
        </div>

        <div class="card c2">
            <h4>➕ Adăugare angajați</h4>
            <div class="corp">
                Completați datele noului angajat. Câmpurile sunt validate, unele au valori implicite, iar după salvare
                salariul se calculează automat. Formularul rămâne deschis pentru adăugarea unui nou angajat.
            </div>
        </div>

        <div class="card c4">
            <h4>🗑️ Ștergere angajați</h4>
            <div class="corp">
                Căutați angajatul după NUME și/sau PRENUME. Dacă sunt găsiți mai mulți, selectați-l pe cel dorit.
                Dacă nu există, se afișează un mesaj.
                <div class="nota">Înainte de ștergere vi se cere confirmarea.</div>
            </div>
        </div>

        <div class="card c3">
            <h4>🧮 Calcul salarii (automat, prin trigger)</h4>
            <div class="corp">
                Recalcularea salariilor tuturor angajaților (de exemplu după modificarea CAS, CASS sau a impozitului)
                se face folosind trigger. Pentru orice modificare adusă datelor angajaților se apelează automat
                trigger-ul care recalculează datele.
                <div class="nota">La final se afișează un mesaj de confirmare.</div>
            </div>
        </div>

        <div class="card c5">
            <h4>📄 Stat plată</h4>
            <div class="corp">
                Afișează statul de plată tabelat pentru toți angajații, cu totaluri pe coloanele
                <span class="camp">TOTAL_BRUT</span><span class="camp">VIRAT_CARD</span><br />
                Raportul poate fi tipărit sau salvat ca fișier PDF, al cărui nume conține luna de calcul.
            </div>
        </div>

        <div class="card c6">
            <h4>🧾 Fluturași</h4>
            <div class="corp">
                Afișează fluturașii tuturor angajaților sau doar pe cel al unui angajat căutat, cu posibilitate de tipărire.
            </div>
        </div>

        <div class="card c7">
            <h4>🔒 Modificare impozit</h4>
            <div class="corp">
                Permite modificarea tabelei cu procente. Accesul este protejat prin parolă.
                <div class="nota">După modificare, salariile se recalculează automat prin trigger.</div>
            </div>
        </div>
    </main>

</asp:Content>