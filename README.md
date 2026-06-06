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
Al menos en 2 tablas

- Loguear como Admin -> hacer un backup -> salir del sistema -> romper 2 tablas (por lo menos en 2 tablas tiene que haber dígito verificador) -> loguear como admin -> cartel "error de integridad y que tabla/s y registro/s están corruptos".

#### Corregir

- Cosas de las contraseña
  - Contraseña 8 caracteres letras may y min y caracter especial
  - Bloquear el usuario desp del 3er intento incorrecto o hacer algo

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

> [!WARNING]
> El profe Necesita que en el TP haya un RegularExpressionValidation (nos dio una hoja con la explicación).

## Usuarios del sistema

Usuario: Lauta
Contraseña: 1234
Rol: Administrador

Usuario: MaxV
Contraseña: 1234
Rol: SinPermisos

Usuario: Nano
Contraseña: 1234
Rol: Cliente

Usuario: Checo
Contraseña: 1234
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
