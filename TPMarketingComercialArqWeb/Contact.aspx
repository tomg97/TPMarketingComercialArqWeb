<%@ Page Title="Contacto" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="TPMarketingComercialArqWeb.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<style>
    .contact-hero {
        background: linear-gradient(135deg, #1a1a2e 0%, #0f3460 100%);
        color: white;
        padding: 50px 40px;
        border-radius: 12px;
        margin-bottom: 36px;
        text-align: center;
    }
    .contact-hero h2 { font-size: 2.4rem; font-weight: 700; margin-bottom: 8px; }
    .contact-hero p  { color: #a0c4ff; font-size: 1.1rem; margin: 0; }

    .contact-grid {
        display: flex;
        gap: 24px;
        flex-wrap: wrap;
        margin-bottom: 36px;
    }
    .contact-card {
        flex: 1;
        min-width: 200px;
        background: #f8f9fa;
        border-radius: 10px;
        border-top: 4px solid #0f3460;
        padding: 28px 24px;
        text-align: center;
    }
    .contact-card .icono { font-size: 2rem; margin-bottom: 12px; }
    .contact-card h5 { color: #0f3460; margin-bottom: 8px; }
    .contact-card p, .contact-card a {
        color: #555;
        font-size: 0.95rem;
        margin: 0;
        text-decoration: none;
    }
    .contact-card a:hover { color: #e94560; }

    .horarios {
        background: #f0f4ff;
        border-left: 5px solid #0f3460;
        border-radius: 8px;
        padding: 28px 32px;
        margin-bottom: 28px;
    }
    .horarios h4 { color: #0f3460; margin-bottom: 16px; }
    .horarios table { width: 100%; border-collapse: collapse; }
    .horarios td { padding: 8px 12px; color: #444; border-bottom: 1px solid #dee2e6; }
    .horarios td:first-child { font-weight: 600; color: #0f3460; width: 200px; }
</style>

<main aria-labelledby="title">

    <div class="contact-hero">
        <h2 id="title">📬 Contacto</h2>
        <p>Estamos para ayudarte. Escribinos o visitanos.</p>
    </div>

    <div class="contact-grid">
        <div class="contact-card">
            <div class="icono">📍</div>
            <h5>Dirección</h5>
            <p>Av. Tecnológica 1234, Piso 2<br/>Buenos Aires, Argentina</p>
        </div>
        <div class="contact-card">
            <div class="icono">📞</div>
            <h5>Teléfono</h5>
            <p>+54 11 4567-8900<br/>+54 11 4567-8901</p>
        </div>
        <div class="contact-card">
            <div class="icono">✉️</div>
            <h5>Correo electrónico</h5>
            <a href="mailto:ventas@3dshop.com.ar">ventas@3dshop.com.ar</a><br/>
            <a href="mailto:soporte@3dshop.com.ar">soporte@3dshop.com.ar</a>
        </div>
        <div class="contact-card">
            <div class="icono">🌐</div>
            <h5>Redes sociales</h5>
            <p>Instagram: @3dshop.ar<br/>Facebook: /3dshopargentina</p>
        </div>
    </div>

    <div class="horarios">
        <h4>🕐 Horarios de atención</h4>
        <table>
            <tr><td>Lunes a Viernes</td><td>9:00 hs — 18:00 hs</td></tr>
            <tr><td>Sábados</td><td>9:00 hs — 13:00 hs</td></tr>
            <tr><td>Domingos y feriados</td><td>Cerrado</td></tr>
            <tr><td>Soporte técnico online</td><td>Lunes a Viernes 9:00 — 20:00 hs</td></tr>
        </table>
    </div>

</main>
</asp:Content>