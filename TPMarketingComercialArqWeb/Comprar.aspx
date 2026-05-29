<%@ Page Title="Comprar" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Comprar.aspx.cs" Inherits="TPMarketingComercialArqWeb.Comprar" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <style>
        .product-header {
        background: linear-gradient(135deg, #1a1a2e 0%, #0f3460 100%);
        color: white;
        padding: 30px 40px;
        border-radius: 10px;
        margin-bottom: 28px;

        }
        .product-header h1 { margin: 0 0 6px 0; font-size: 2rem; letter-spacing: 1px; }
        .product-header p  { margin: 0; color: #a0c4ff; }
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            padding: 20px 0;
        }
        .product-card {
            border: 1px solid #ebebeb;
            border-radius: 8px;
            padding: 15px;
            background-color: #fff;
            box-shadow: 0 1px 2px rgba(0,0,0,0.1);
            transition: box-shadow 0.3s ease;
            cursor: pointer;
        }
        .product-card:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .product-img {
            width: 100%;
            height: 200px;
            object-fit: contain; /* Para que la imagen no se deforme */
            margin-bottom: 15px;
        }
        .product-title {
            font-size: 14px;
            color: #333;
            margin: 0 0 10px 0;
            font-weight: 300;
            display: -webkit-box;
            -webkit-line-clamp: 2; /* Limita a 2 líneas de texto */
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .product-price {
            font-size: 24px;
            font-weight: 400;
            color: #333;
            margin: 0 0 5px 0;
        }
        .shipping-badge {
            font-size: 12px;
            color: #0f3460; /* Color azul */
            font-weight: 600;
        }
    </style>

    <main>
        <section class="row" aria-labelledby="aspnetTitle"></section>

        <div class="product-header">
            <h1 id="aspnetTitle">🛍️ Catálogo de productos</h1>
            <p>Seleccione los productos que desea comprar.</p>
        </div>

        <div class="row">
            <div class="product-grid">
                <asp:Repeater ID="rptProductos" runat="server">
                    <ItemTemplate>
                        <div class="product-card">
                            <img src='<%# ObtenerImagenBase64(Eval("Imagen")) %>' alt='<%# Eval("Nombre") %>' class="product-img" />
                            
                            <div class="product-info">
                                <h3 class="product-title"><%# Eval("Nombre") %></h3>
                                <p class="product-price">$ <%# Convert.ToDecimal(Eval("PrecioBase")).ToString("N0") %></p>
                                <span class="shipping-badge">Llega gratis hoy</span>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </main>

</asp:Content>