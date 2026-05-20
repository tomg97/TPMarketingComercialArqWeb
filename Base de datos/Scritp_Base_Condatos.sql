USE [TpArqWeb]
GO
/****** Object:  Table [dbo].[BITACORAEVENTOS]    Script Date: 2026-05-20 15:01:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BITACORAEVENTOS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idusuario] [int] NULL,
	[fecha] [datetime] NULL,
	[accion] [varchar](50) NULL,
 CONSTRAINT [PK_BITACORAEVENTOS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ETIQUETA]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ETIQUETA](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ETIQUETA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IDIOMA]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IDIOMA](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[pordefecto] [bit] NOT NULL,
	[listoparausar] [bit] NOT NULL,
 CONSTRAINT [PK_Idioma] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PERMISOS]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERMISOS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[tipo] [varchar](50) NULL,
 CONSTRAINT [PK_PERMISOS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PERMISOS_PERMISOS]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERMISOS_PERMISOS](
	[idpermisopadre] [int] NOT NULL,
	[idpermisohijo] [int] NOT NULL,
 CONSTRAINT [PK_PERMISOS_PERMISOS] PRIMARY KEY CLUSTERED 
(
	[idpermisopadre] ASC,
	[idpermisohijo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TABLA_DVV]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TABLA_DVV](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombretabla] [varchar](50) NULL,
	[digitovertical] [varchar](70) NULL,
 CONSTRAINT [PK_TABLA_DVV] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRADUCCION]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRADUCCION](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ididioma] [int] NOT NULL,
	[idetiqueta] [int] NOT NULL,
	[texto] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TRADUCCION] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[ididioma] ASC,
	[idetiqueta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USUARIOS]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIOS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombredeusuario] [varchar](50) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[apellido] [varchar](50) NOT NULL,
	[contrasenia] [varchar](50) NOT NULL,
	[correo] [varchar](50) NOT NULL,
	[ididioma] [int] NULL,
 CONSTRAINT [PK_USUARIO] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USUARIOS_PERMISOS]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIOS_PERMISOS](
	[idusuario] [int] NOT NULL,
	[idpermiso] [int] NOT NULL,
 CONSTRAINT [PK_USUARIOS_PERMISOS] PRIMARY KEY CLUSTERED 
(
	[idusuario] ASC,
	[idpermiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BITACORAEVENTOS] ON 
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (1, 1, CAST(N'2026-05-20T14:23:40.427' AS DateTime), N'Log In')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (2, 1, CAST(N'2026-05-20T14:23:44.970' AS DateTime), N'Abrir ABM de usuarios')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (3, 1, CAST(N'2026-05-20T14:23:56.257' AS DateTime), N'Log Out')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (4, 4, CAST(N'2026-05-20T14:24:19.740' AS DateTime), N'Log In')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (5, 4, CAST(N'2026-05-20T14:24:22.493' AS DateTime), N'Abrir Bitacora')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (6, 1, CAST(N'2026-05-20T14:31:12.267' AS DateTime), N'Log In')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (7, 1, CAST(N'2026-05-20T14:31:16.723' AS DateTime), N'Abrió ABM de usuarios')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (8, 1, CAST(N'2026-05-20T14:31:16.763' AS DateTime), N'Cerró ABM de usuarios')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (9, 1, CAST(N'2026-05-20T14:31:24.327' AS DateTime), N'Cerró ABM de usuarios')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (10, 1, CAST(N'2026-05-20T14:31:31.233' AS DateTime), N'Modificó un usuario')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (11, 1, CAST(N'2026-05-20T14:31:31.263' AS DateTime), N'Cerró ABM de usuarios')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (12, 1, CAST(N'2026-05-20T14:31:35.900' AS DateTime), N'Log Out')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (13, 4, CAST(N'2026-05-20T14:31:44.310' AS DateTime), N'Log In')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (14, 4, CAST(N'2026-05-20T14:31:47.383' AS DateTime), N'Abrir Bitacora')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (15, 1, CAST(N'2026-05-20T14:37:46.560' AS DateTime), N'Log In')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (16, 1, CAST(N'2026-05-20T14:37:49.963' AS DateTime), N'Abrió Bitacora')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (17, 1, CAST(N'2026-05-20T14:38:59.833' AS DateTime), N'Log In')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (18, 1, CAST(N'2026-05-20T14:39:02.590' AS DateTime), N'Abrió ABM de usuarios')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (19, 1, CAST(N'2026-05-20T14:39:03.943' AS DateTime), N'Abrió Bitacora')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (20, 1, CAST(N'2026-05-20T14:40:05.950' AS DateTime), N'Log In')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (21, 1, CAST(N'2026-05-20T14:40:07.927' AS DateTime), N'Abrió Bitacora')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (22, 1, CAST(N'2026-05-20T14:41:04.317' AS DateTime), N'Log In')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (23, 1, CAST(N'2026-05-20T14:41:33.207' AS DateTime), N'Log Out')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (24, 4, CAST(N'2026-05-20T14:41:55.543' AS DateTime), N'Log In')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (25, 4, CAST(N'2026-05-20T14:41:58.383' AS DateTime), N'Abrió Bitacora')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (26, 1, CAST(N'2026-05-20T14:45:32.980' AS DateTime), N'Log In')
GO
INSERT [dbo].[BITACORAEVENTOS] ([id], [idusuario], [fecha], [accion]) VALUES (27, 1, CAST(N'2026-05-20T14:45:36.700' AS DateTime), N'Abrió Bitacora')
GO
SET IDENTITY_INSERT [dbo].[BITACORAEVENTOS] OFF
GO
SET IDENTITY_INSERT [dbo].[IDIOMA] ON 
GO
INSERT [dbo].[IDIOMA] ([id], [nombre], [pordefecto], [listoparausar]) VALUES (1, N'Castellano', 1, 1)
GO
INSERT [dbo].[IDIOMA] ([id], [nombre], [pordefecto], [listoparausar]) VALUES (2, N'English', 0, 0)
GO
INSERT [dbo].[IDIOMA] ([id], [nombre], [pordefecto], [listoparausar]) VALUES (3, N'Deutsch', 0, 0)
GO
SET IDENTITY_INSERT [dbo].[IDIOMA] OFF
GO
SET IDENTITY_INSERT [dbo].[PERMISOS] ON 
GO
INSERT [dbo].[PERMISOS] ([id], [nombre], [tipo]) VALUES (1, N'Administrador', NULL)
GO
INSERT [dbo].[PERMISOS] ([id], [nombre], [tipo]) VALUES (2, N'SinPermisos', NULL)
GO
INSERT [dbo].[PERMISOS] ([id], [nombre], [tipo]) VALUES (3, N'Cliente', NULL)
GO
INSERT [dbo].[PERMISOS] ([id], [nombre], [tipo]) VALUES (4, N'Seguridad', NULL)
GO
INSERT [dbo].[PERMISOS] ([id], [nombre], [tipo]) VALUES (5, N'SinPermisos', N'Accion')
GO
INSERT [dbo].[PERMISOS] ([id], [nombre], [tipo]) VALUES (6, N'GestionarPermisosDeUsuarios', N'Accion')
GO
INSERT [dbo].[PERMISOS] ([id], [nombre], [tipo]) VALUES (7, N'GestionarPermisos', N'Accion')
GO
INSERT [dbo].[PERMISOS] ([id], [nombre], [tipo]) VALUES (8, N'GestionarBitacoraEventos', N'Accion')
GO
INSERT [dbo].[PERMISOS] ([id], [nombre], [tipo]) VALUES (9, N'GestionarBackup', N'Accion')
GO
INSERT [dbo].[PERMISOS] ([id], [nombre], [tipo]) VALUES (10, N'ABMUsuarios', N'Accion')
GO
INSERT [dbo].[PERMISOS] ([id], [nombre], [tipo]) VALUES (11, N'Comprar', N'Accion')
GO
SET IDENTITY_INSERT [dbo].[PERMISOS] OFF
GO
INSERT [dbo].[PERMISOS_PERMISOS] ([idpermisopadre], [idpermisohijo]) VALUES (1, 6)
GO
INSERT [dbo].[PERMISOS_PERMISOS] ([idpermisopadre], [idpermisohijo]) VALUES (1, 7)
GO
INSERT [dbo].[PERMISOS_PERMISOS] ([idpermisopadre], [idpermisohijo]) VALUES (1, 8)
GO
INSERT [dbo].[PERMISOS_PERMISOS] ([idpermisopadre], [idpermisohijo]) VALUES (1, 9)
GO
INSERT [dbo].[PERMISOS_PERMISOS] ([idpermisopadre], [idpermisohijo]) VALUES (1, 10)
GO
INSERT [dbo].[PERMISOS_PERMISOS] ([idpermisopadre], [idpermisohijo]) VALUES (2, 5)
GO
INSERT [dbo].[PERMISOS_PERMISOS] ([idpermisopadre], [idpermisohijo]) VALUES (3, 11)
GO
INSERT [dbo].[PERMISOS_PERMISOS] ([idpermisopadre], [idpermisohijo]) VALUES (4, 6)
GO
INSERT [dbo].[PERMISOS_PERMISOS] ([idpermisopadre], [idpermisohijo]) VALUES (4, 7)
GO
INSERT [dbo].[PERMISOS_PERMISOS] ([idpermisopadre], [idpermisohijo]) VALUES (4, 8)
GO
INSERT [dbo].[PERMISOS_PERMISOS] ([idpermisopadre], [idpermisohijo]) VALUES (4, 9)
GO
SET IDENTITY_INSERT [dbo].[USUARIOS] ON 
GO
INSERT [dbo].[USUARIOS] ([id], [nombredeusuario], [nombre], [apellido], [contrasenia], [correo], [ididioma]) VALUES (1, N'Lauta', N'Lautaro', N'Rojas', N'dOLrys7faKWPqir8OWcMNA==', N'lautaro.rojas02@gmail.com', 1)
GO
INSERT [dbo].[USUARIOS] ([id], [nombredeusuario], [nombre], [apellido], [contrasenia], [correo], [ididioma]) VALUES (2, N'MaxV', N'Max', N'Verstappen', N'dOLrys7faKWPqir8OWcMNA==', N'max.verstappen@gmail.com', 1)
GO
INSERT [dbo].[USUARIOS] ([id], [nombredeusuario], [nombre], [apellido], [contrasenia], [correo], [ididioma]) VALUES (3, N'Nano', N'Fernando', N'Alonso', N'dOLrys7faKWPqir8OWcMNA==', N'fernando.alonso@gmail.com', 1)
GO
INSERT [dbo].[USUARIOS] ([id], [nombredeusuario], [nombre], [apellido], [contrasenia], [correo], [ididioma]) VALUES (4, N'Checo', N'Sergio', N'Perez', N'dOLrys7faKWPqir8OWcMNA==', N'sergio.perez@gmail.com', 1)
GO
INSERT [dbo].[USUARIOS] ([id], [nombredeusuario], [nombre], [apellido], [contrasenia], [correo], [ididioma]) VALUES (5, N'CharLec', N'Charles', N'Leclerc', N'dOLrys7faKWPqir8OWcMNA==', N'charles.leclerc@gmail.com', 2)
GO
INSERT [dbo].[USUARIOS] ([id], [nombredeusuario], [nombre], [apellido], [contrasenia], [correo], [ididioma]) VALUES (6, N'Nor', N'Lando', N'Norris', N'jaERRQ8Pl2OPqir8OWcMNA==', N'lando.norris@gmail.com', 2)
GO
INSERT [dbo].[USUARIOS] ([id], [nombredeusuario], [nombre], [apellido], [contrasenia], [correo], [ididioma]) VALUES (7, N'CarlosJr', N'Carlos', N'Sainz Jr', N'dOLrys7faKWPqir8OWcMNA==', N'carlos.sainzjr@gmail.com', 1)
GO
INSERT [dbo].[USUARIOS] ([id], [nombredeusuario], [nombre], [apellido], [contrasenia], [correo], [ididioma]) VALUES (8, N'OscarP', N'Oscar', N'Piastri', N'dOLrys7faKWPqir8OWcMNA==', N'oscar.piastri@gmail.com', 1)
GO
INSERT [dbo].[USUARIOS] ([id], [nombredeusuario], [nombre], [apellido], [contrasenia], [correo], [ididioma]) VALUES (9, N'Fran', N'Franco', N'Colapinto', N'dOLrys7faKWPqir8OWcMNA==', N'franco.colapinto@gmail.com', 1)
GO
INSERT [dbo].[USUARIOS] ([id], [nombredeusuario], [nombre], [apellido], [contrasenia], [correo], [ididioma]) VALUES (10, N'TPose', N'George', N'Russell', N'dOLrys7faKWPqir8OWcMNA==', N'george.russell@gmail.com', 1)
GO
SET IDENTITY_INSERT [dbo].[USUARIOS] OFF
GO
INSERT [dbo].[USUARIOS_PERMISOS] ([idusuario], [idpermiso]) VALUES (1, 1)
GO
INSERT [dbo].[USUARIOS_PERMISOS] ([idusuario], [idpermiso]) VALUES (2, 2)
GO
INSERT [dbo].[USUARIOS_PERMISOS] ([idusuario], [idpermiso]) VALUES (3, 3)
GO
INSERT [dbo].[USUARIOS_PERMISOS] ([idusuario], [idpermiso]) VALUES (4, 4)
GO
/****** Object:  StoredProcedure [dbo].[ACCION_LISTAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[ACCION_LISTAR]
AS
BEGIN
	SELECT * FROM PERMISOS WHERE tipo IS NOT NULL
END
GO
/****** Object:  StoredProcedure [dbo].[BITACORAEVENTOS_INSERTAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[BITACORAEVENTOS_INSERTAR]
@idusuario int, @fecha datetime, @accion varchar(50)
AS
BEGIN
	INSERT INTO BITACORAEVENTOS VALUES (@idusuario, @fecha, @accion)
END
GO
/****** Object:  StoredProcedure [dbo].[BITACORAEVENTOS_LISTAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[BITACORAEVENTOS_LISTAR]
AS
BEGIN
	SELECT * FROM BITACORAEVENTOS
END
GO
/****** Object:  StoredProcedure [dbo].[IDIOMA_BORRAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[IDIOMA_BORRAR]
@id int
AS
BEGIN
	DELETE FROM TRADUCCION WHERE ididioma = @id
	DELETE FROM IDIOMA WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[IDIOMA_BUSCAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[IDIOMA_BUSCAR]
@nombre varchar(50)
AS
BEGIN
	SELECT * FROM IDIOMA WHERE nombre = @nombre
END
GO
/****** Object:  StoredProcedure [dbo].[IDIOMA_EDITAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[IDIOMA_EDITAR]
@id int, @nombre varchar(50), @listoparausar bit
AS
BEGIN
	UPDATE IDIOMA SET 
		nombre = @nombre,
		listoparausar = @listoparausar
	WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[IDIOMA_INSERTAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[IDIOMA_INSERTAR]
@nombre varchar(50), @pordefecto bit, @listoparausar bit
AS
BEGIN
	INSERT INTO IDIOMA VALUES (@nombre, @pordefecto, @listoparausar)
	--Cree un trigger para cuando se inserte un nuevo idioma se puedan crear las traducciones de forma automática
END
GO
/****** Object:  StoredProcedure [dbo].[IDIOMA_LISTAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[IDIOMA_LISTAR]
AS
BEGIN
	SELECT * FROM IDIOMA
END
GO
/****** Object:  StoredProcedure [dbo].[OBTENER_TRADUCCIONES]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[OBTENER_TRADUCCIONES]
@ididioma int
AS
BEGIN
	SELECT t.id AS 'idtraduccion', i.id AS 'ididioma', i.nombre AS 'nombreidioma', i.pordefecto, e.id AS 'idetiqueta', e.nombre AS 'nombreetiqueta', t.texto AS 'traduccion' FROM TRADUCCION t INNER JOIN IDIOMA i ON t.ididioma = i.id INNER JOIN ETIQUETA e ON t.idetiqueta = e.id WHERE i.id = @ididioma
END
GO
/****** Object:  StoredProcedure [dbo].[PERMISO_INSERTAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PERMISO_INSERTAR]
@nombre varchar(50), @tipo varchar(50)
AS
BEGIN
	INSERT INTO PERMISOS VALUES (@nombre, @tipo)
	--SELECT id AS LastID FROM PERMISOS WHERE id = @@Identity
END
GO
/****** Object:  StoredProcedure [dbo].[PERMISO_LISTAR_RECURSIVO]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[PERMISO_LISTAR_RECURSIVO]
@where varchar(50)
AS
BEGIN
	WITH recursivo AS	(
							SELECT PP2.idpermisopadre, PP2.idpermisohijo FROM PERMISOS_PERMISOS PP2
							WHERE PP2.idpermisopadre = @where --acá se va variando la familia que busco
							UNION ALL 
							SELECT PP1.idpermisopadre, PP1.idpermisohijo FROM PERMISOS_PERMISOS PP1 
							inner join recursivo rec ON rec.idpermisohijo = PP1.idpermisopadre
						)
						SELECT rec.idpermisopadre, rec.idpermisohijo, P.id, P.nombre, P.tipo
						FROM recursivo rec 
						inner join PERMISOS P ON rec.idpermisohijo = P.id
END
GO
/****** Object:  StoredProcedure [dbo].[PERMISO_PERMISO_BORRAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[PERMISO_PERMISO_BORRAR]
@id int
AS
BEGIN
	DELETE FROM PERMISOS_PERMISOS WHERE idpermisopadre = @id
END
GO
/****** Object:  StoredProcedure [dbo].[PERMISO_PERMISO_INSERTAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[PERMISO_PERMISO_INSERTAR]
@idpermisopadre int, @idpermisohijo int
AS
BEGIN
	INSERT INTO PERMISOS_PERMISOS VALUES (@idpermisopadre, @idpermisohijo) 
END
GO
/****** Object:  StoredProcedure [dbo].[REALIZAR_BACKUP]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[REALIZAR_BACKUP]
@nombrebd varchar(50), @rutabackup varchar(200)
AS
BEGIN
	BACKUP DATABASE @nombrebd TO DISK = @rutabackup
END
GO
/****** Object:  StoredProcedure [dbo].[ROL_LISTAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[ROL_LISTAR]
AS
BEGIN
	SELECT * FROM PERMISOS WHERE tipo IS NULL
END
GO
/****** Object:  StoredProcedure [dbo].[TABLA_DVV_INSERTAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TABLA_DVV_INSERTAR] --Digito verificador vertical
@nombretabla varchar(50), @digitovertical varchar(70)
AS
BEGIN
	IF EXISTS (SELECT * FROM TABLA_DVV WHERE nombretabla = @nombretabla)
	BEGIN
		UPDATE TABLA_DVV SET 
			digitovertical = @digitovertical
		WHERE nombretabla = @nombretabla;
	END
	ELSE
	BEGIN
		INSERT INTO TABLA_DVV VALUES (@nombretabla, @digitovertical);
	END
END
GO
/****** Object:  StoredProcedure [dbo].[USUARIO_BORRAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USUARIO_BORRAR]
@id int
AS 
BEGIN
	DELETE FROM USUARIOS WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[USUARIO_BUSCAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USUARIO_BUSCAR]
@nombredeusuario varchar(50), @contrasenia varchar(50)
AS
BEGIN
	SELECT * FROM USUARIOS WHERE nombredeusuario = @nombredeusuario AND contrasenia = @contrasenia
END
GO
/****** Object:  StoredProcedure [dbo].[USUARIO_BUSCARID]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USUARIO_BUSCARID]
@id int
AS
BEGIN
	SELECT * FROM USUARIOS WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[USUARIO_EDITAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USUARIO_EDITAR]
@id int, @nombredeusuario varchar(50), @contrasenia varchar(50), @nombre varchar(50), @apellido varchar(50), @correo varchar(50), @ididioma int 
AS 
BEGIN
	update USUARIOS SET 
		nombredeusuario = @nombredeusuario, 
		contrasenia = @contrasenia,
		nombre = @nombre,
		apellido = @apellido,
		correo = @correo,
		ididioma = @ididioma
	WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[USUARIO_INSERTAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USUARIO_INSERTAR]
@nombredeusuario varchar(50), @nombre varchar(50), @apellido varchar(50), @contrasenia varchar(50), @correo varchar(50), @ididioma int
AS 
BEGIN
	INSERT INTO USUARIOS VALUES (@nombredeusuario, @nombre, @apellido, @contrasenia, @correo, @ididioma)
END
GO
/****** Object:  StoredProcedure [dbo].[USUARIO_LISTAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USUARIO_LISTAR]
AS
BEGIN
	SELECT * FROM USUARIOS
END
GO
/****** Object:  StoredProcedure [dbo].[USUARIO_PERMISO_LISTAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USUARIO_PERMISO_LISTAR]
@id int
AS
BEGIN
	SELECT P.* FROM USUARIOS_PERMISOS UP INNER JOIN PERMISOS P ON UP.idpermiso = P.id WHERE idusuario = @id
END
GO
/****** Object:  StoredProcedure [dbo].[USUARIOS_PERMISOS_BORRAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USUARIOS_PERMISOS_BORRAR]
@id int
AS
BEGIN
	DELETE FROM USUARIOS_PERMISOS WHERE idusuario = @id
END
GO
/****** Object:  StoredProcedure [dbo].[USUARIOS_PERMISOS_INSERTAR]    Script Date: 2026-05-20 15:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USUARIOS_PERMISOS_INSERTAR]
@idusuario int, @idpermiso int
AS
BEGIN
	INSERT INTO USUARIOS_PERMISOS VALUES (@idusuario, @idpermiso)
END
GO
