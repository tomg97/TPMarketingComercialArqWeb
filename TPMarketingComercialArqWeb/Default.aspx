<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TPMarketingComercialArqWeb._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<style>
    .hero-section {
        background: linear-gradient(135deg, #1a1a2e 0%, #0f3460 100%);
        color: white;
        padding: 60px 40px;
        border-radius: 12px;
        margin-bottom: 36px;
        text-align: center;
    }
    .hero-section h1 {
        font-size: 2.8rem;
        font-weight: 700;
        letter-spacing: 3px;
        margin-bottom: 8px;
    }
    .hero-section .lead {
        color: #a0c4ff;
        font-size: 1.2rem;
        margin-bottom: 28px;
    }
    .features {
        display: flex;
        gap: 20px;
        flex-wrap: wrap;
        margin-bottom: 36px;
    }
    .feature-card {
        flex: 1;
        min-width: 180px;
        background: #f8f9fa;
        border-left: 4px solid #0f3460;
        border-radius: 8px;
        padding: 20px;
    }
    .feature-card h5 {
        color: #0f3460;
        margin-bottom: 6px;
    }
    .feature-card p {
        color: #555;
        font-size: 0.9rem;
        margin: 0;
    }
    .about-section {
        background: #f0f4ff;
        border-radius: 10px;
        padding: 32px;
    }
    .about-section h4 {
        color: #0f3460;
        margin-bottom: 12px;
    }
    .about-section p {
        color: #444;
        line-height: 1.8;
        margin: 0;
    }
</style>

<main>
    <section class="row" aria-labelledby="aspnetTitle">

        <!-- Hero -->
        <div class="hero-section">
            <h1 id="aspnetTitle">3D SHOP</h1>
            <p class="lead">Tienda Online de piezas e insumos impresos en 3D</p>
            <a href="Login.aspx" class="btn btn-primary btn-md">Log in »</a>
        </div>

        <!-- Cards -->
        <div class="features">
            <div class="feature-card">
                <h5>🎯 Diseño a medida</h5>
                <p>Piezas personalizadas según las especificaciones exactas de cada cliente.</p>
            </div>
            <div class="feature-card">
                <h5>⚡ Entrega rápida</h5>
                <p>Producción ágil con tecnología de última generación.</p>
            </div>
            <div class="feature-card">
                <h5>🔩 Alta precisión</h5>
                <p>Tolerancias de 0.1mm para componentes técnicos e industriales.</p>
            </div>
            <div class="feature-card">
                <h5>🌿 Materiales variados</h5>
                <p>PLA, ABS, PETG, resina y más. El material ideal para tu proyecto.</p>
            </div>
        </div>

        <!-- Sobre la empresa -->
        <div class="about-section">
            <h4>¿Quiénes somos?</h4>
            <p>
                <strong>3D Shop</strong> es una empresa especializada en la fabricación y comercialización 
                de artículos producidos mediante impresión 3D. Trabajamos con los mejores materiales del 
                mercado para garantizar calidad superior, desde repuestos técnicos hasta piezas decorativas.
            </p>
        </div>

    </section>
</main>
</asp:Content>