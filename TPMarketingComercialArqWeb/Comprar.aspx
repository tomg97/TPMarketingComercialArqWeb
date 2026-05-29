<%@ Page Title="Comprar" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Comprar.aspx.cs" Inherits="TPMarketingComercialArqWeb.Comprar" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <style>
        /* --- Grilla de Productos --- */
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
        .btn-agregar { width: 100%; background: #3483fa; color: #fff; border: none; padding: 8px; border-radius: 4px; font-weight: bold; text-align: center; text-decoration: none; display: block; }
        .btn-agregar:hover { background: #2969cb; color: #fff; }
        
        /* --- Panel Lateral (Carrito) --- */
        .cart-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1040; display: none; }
        .cart-overlay.open { display: block; }
        
        .cart-sidebar { position: fixed; right: -420px; top: 0; width: 400px; height: 100%; background: #fff; z-index: 1050; transition: right 0.3s ease; padding: 20px; display: flex; flex-direction: column; box-shadow: -2px 0 10px rgba(0,0,0,0.1); }
        .cart-sidebar.open { right: 0; }
        
        .cart-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #eee; padding-bottom: 10px; }
        .btn-close-cart { background: none; border: none; font-size: 20px; cursor: pointer; }
        
        .cart-items { flex: 1; overflow-y: auto; padding: 10px 0; }
        .cart-item { display: flex; align-items: center; gap: 10px; border-bottom: 1px solid #f5f5f5; padding: 10px 0; }
        .cart-item-img { width: 50px; height: 50px; object-fit: contain; }
        .cart-item-details { flex: 1; }
        .cart-item-title { font-size: 12px; margin: 0; }
        .cart-item-price { font-size: 14px; font-weight: bold; margin: 5px 0 0 0; }
        
        /* Controles de Cantidad */
        .quantity-controls { display: flex; align-items: center; gap: 5px; margin-top: 5px; }
        .btn-qty { background: #eee; border: none; width: 25px; height: 25px; border-radius: 4px; cursor: pointer; font-weight: bold; }
        .qty-value { font-size: 14px; min-width: 20px; text-align: center; }
        .btn-eliminar { background: none; border: none; color: #cc0000; font-size: 12px; cursor: pointer; margin-left: auto; }

        .cart-footer { border-top: 1px solid #eee; padding-top: 15px; }
        .cart-total { display: flex; justify-content: space-between; font-size: 18px; font-weight: bold; margin-bottom: 15px; }
        .btn-comprar { width: 100%; background: #00a650; color: #fff; border: none; padding: 12px; border-radius: 6px; font-size: 16px; font-weight: bold; cursor: pointer; }
        .btn-comprar:hover { background: #008741; }
    </style>


    <asp:UpdatePanel ID="upEcommerce" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            
            <main>
                <section class="row">
                    <div class="product-header" style="display: flex; justify-content: space-between; align-items: center;">
        
                        <div>
                            <h1 id="aspnetTitle" style="margin-top: 0; margin-bottom: 5px;">🛍️ Catálogo de productos</h1>
                            <p style="margin-bottom: 0;">Seleccione los productos que desea comprar.</p>
                        </div>

                        <div>
                            <asp:LinkButton ID="btnVerCarrito" runat="server" OnClick="btnVerCarrito_Click" CssClass="btn btn-outline-light">
                                🛒 Ver Carrito
                            </asp:LinkButton>
                        </div>

                    </div>
                </section>

                <div class="product-grid">
                    <asp:Repeater ID="rptProductos" runat="server" OnItemCommand="rptProductos_ItemCommand">
                        <ItemTemplate>
                            <div class="product-card">
                                <img src='<%# ObtenerImagenBase64(Eval("Imagen")) %>' class="product-img" />
                                <div>
                                    <h3 class="product-title"><%# Eval("Nombre") %></h3>
                                    <p class="product-price">$ <%# Convert.ToDecimal(Eval("PrecioBase")).ToString("N0") %></p>
                                </div>
                                <asp:LinkButton ID="btnAgregar" runat="server" 
                                    CommandName="AgregarAlCarrito" 
                                    CommandArgument='<%# Eval("Id") %>' 
                                    CssClass="btn-agregar">Agregar al carrito</asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </main>

            <div class="cart-overlay <% =CartStateClass %>"></div>

            <div class="cart-sidebar <% =CartStateClass %>">
                <div class="cart-header">
                    <h2>Mi Carrito</h2>
                    <asp:Button ID="btnCerrar" runat="server" Text="✕" CssClass="btn-close-cart" OnClick="btnCerrar_Click" />
                </div>

                <div class="cart-items">
                    <asp:Repeater ID="rptCarrito" runat="server" OnItemCommand="rptCarrito_ItemCommand">
                        <ItemTemplate>
                            <div class="cart-item">
                                <img src='<%# ObtenerImagenBase64(Eval("Imagen")) %>' class="cart-item-img" />
                                <div class="cart-item-details">
                                    <h4 class="cart-item-title"><%# Eval("Nombre") %></h4>
                                    <p class="cart-item-price">$ <%# Convert.ToDecimal(Eval("Precio")).ToString("N0") %></p>
                                    <div class="quantity-controls">
                                        <asp:Button ID="btnRestar" runat="server" Text="-" CssClass="btn-qty" CommandName="RestarQty" CommandArgument='<%# Eval("Id") %>' />
                                        <span class="qty-value"><%# Eval("Cantidad") %></span>
                                        <asp:Button ID="btnSumar" runat="server" Text="+" CssClass="btn-qty" CommandName="SumarQty" CommandArgument='<%# Eval("Id") %>' />
                                    </div>
                                </div>
                                <asp:LinkButton ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn-eliminar" CommandName="EliminarItem" CommandArgument='<%# Eval("Id") %>' />
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    
                    <asp:Panel ID="pnlVacio" runat="server" Visible="false" Style="text-align:center; padding-top:40px; color:#999;">
                        El carrito está vacío.
                    </asp:Panel>
                </div>

                <div class="cart-footer">
                    <div class="cart-total">
                        <span>Total:</span>
                        <span>$ <asp:Literal ID="litTotal" runat="server" Text="0" /></span>
                    </div>
                    <asp:Button ID="btnFinalizarCompra" runat="server" Text="Comprar" CssClass="btn-comprar" OnClick="btnFinalizarCompra_Click" />
                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>