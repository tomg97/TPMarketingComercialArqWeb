# TPMarketingComercial

Usemos este readme para dejar los requisitos del TP.

## Entrega 1 -> 26/5

### Requisitos funcionales

Mapa de navegación, Login & Bitácora

#### Login

El requisito es aunque sea tener, 3 tipos de perfiles.

Como no hay persistencia contra una base de datos, hay que harcodear los login

Cuando se realiza un login
  Se confirma el éxito con un mensaje a mostrar
  Se informa del login erróneo

El día de la presentación hay que mostrarle al profe logins funcionales y no

#### Bitácora

Para la primer entrega solamente debemos mostrar los login - logout

## Entrega 2 -> 16/06 aprox

### Requisitos funcionales

#### Dígito Verificador

Al menos en 2 tablas.

1. Loguear como Admin.
2. Hacer un backup.
3. Salir del sistema.
4. Romper 2 tablas (por lo menos en 2 tablas tiene que haber dígito verificador).
5. Loguear como admin.
6. Cartel "error de integridad y que tabla/s y registro/s están corruptos".
7. Hacer el restore.
8. Salir del sistema.
9. Volver a loguear.

##### Cómo se impementó

Cuando se loguea el ADMIN le aparece el cartel de inconsistencia marcando que tabla y registro y que solo pueda acceder a las páginas, LogOut y Backup.

Cuando se loguea alguien que NO es el Admin, le aparece el cartel de inconsistencia y que se comunique con el Administrador y que solo pueda acceder a la página LogOut.

Siempre al loguearse, no al cargar la página.

#### Correxiones

##### Contraseña

8 caracteres letras may y min y caracter especial y un número.

Se usó un RegularExpressionValidator:

``` XML
<asp:RegularExpressionValidator 
    ID="revPassword" 
    runat="server" 
    ControlToValidate="txtPassword" 
    ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$" 
    ErrorMessage="La contraseña debe tener al menos 8 caracteres, una mayúscula, una minúscula, un número y un carácter especial (@$!%*?&)." 
    ForeColor="Red"
    Display="Dynamic">
</asp:RegularExpressionValidator>
```

- ^ : Indica el inicio de la línea de texto.
- (?=.*[a-z]) : Verifica que exista al menos una letra minúscula (de la a a la z).
- (?=.*[A-Z]) : Verifica que exista al menos una letra mayúscula (de la A a la Z).
- (?=.*\d) : Verifica que exista al menos un número (dígito).
- .{8,} : Establece que la longitud total debe ser de 8 caracteres o más (el punto significa "cualquier carácter").
- $ : Indica el final de la línea de texto.
- (?=.*[@$!%*?&]) : Verifica que exista al menos un carácter especial dentro de los corchetes.

##### Bloqueo de usuario

Bloquear el usuario desp del 3er intento incorrecto.

#### Carrito de compras (si llegamos a hacerlo genial)

Carrito de compras (básico).

## Requisitos de carpeta

La carpeta fue pedida en "capas". Para cada una de las capas, hay que pegar, código y capturas de su funcionamiento.

Arrancamos con una carátula; debemos agregar encabezado y pié de página.

Luego de la carátula, una introducción al propósito del proyecto. El profe lo describió como,

Un primer párrafo que explicite la motivación por expandir el "negocio" a internet. El siguiente párrafo debe describir beneficios para el cliente. El siguiente, beneficiosd para la empresa

#### 1ra capa

Interfaz gráfica (UI)

- Fotos del IDE de desarrollo con las clases
- Aspx de la interfaz de usuario
- Código
- Solo el código de login que lo autentica
- Quiere un diagrama de secuencia conceptual, de cómo se hace el login en el sistema, con el fragmento de código dentro.

#### 2da capa

Acceso a datos (DAL)

#### 3ra capa

Capa de negocios (BLL)

#### 4ta capa

Entidades (BE)

#### Anexo

Acá documentamos los Casos de Uso de login + bitácora

## Usuarios del sistema

Usuario: Lauta
Contraseña: PasswSafe!42
Rol: Administrador

Usuario: MaxV
Contraseña: PasswSafe!42
Rol: SinPermisos

Usuario: Nano
Contraseña: PasswSafe!42
Rol: Cliente

Usuario: Checo
Contraseña: PasswSafe!42
Rol: Seguridad

## Roles y permisos

- Administrador
  - GestionarPermisosDeUsuarios
  - GestionarPermisos
  - GestionarBitacoraEventos
  - GestionarBackup
  - ABMUsuarios
- SinPermisos
  - SinPermisos
- Cliente
  - Comprar
- Seguridad
  - GestionarPermisosDeUsuarios
  - GestionarPermisos
  - GestionarBitacoraEventos
  - GestionarBackup

## Mejoras

- Verificar el stock de los productos antes de mostrar las tarjetas.
