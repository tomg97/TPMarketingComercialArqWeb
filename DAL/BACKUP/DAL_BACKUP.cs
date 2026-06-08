using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.BACKUP
{
    public class DAL_BACKUP
    {
        internal DAL_ACCESOBD acceso = new DAL_ACCESOBD();

        string NombreBD = "TpArqWeb";

        public DAL_BACKUP()
        {
            acceso.AbrirConexion();
        }

        // Devuelve la ruta completa del archivo .bak creado (o null si falla)
        public string RealizarBackup()
        {
            string rutaDirectorio = "C:\\BackupTpArqWeb";
            if (!Directory.Exists(rutaDirectorio))
            {
                Directory.CreateDirectory(rutaDirectorio);
            }

            string rutaBackup = $"{rutaDirectorio}\\{DateTime.Now:dd_MM_yyyy_HH-mm}_3DShop.bak";
            //Cuidado porque si en el store procedure ponemos rutabackup varchar(50) no entran todos los caracteres de la ruta

            List<SqlParameter> parametros = new List<SqlParameter>();
            SqlParameter p = acceso.CrearParametro("@rutabackup", rutaBackup);
            parametros.Add(p);
            p = acceso.CrearParametro("@nombrebd", NombreBD);
            parametros.Add(p);

            int res = acceso.Escribir("REALIZAR_BACKUP", parametros);
            //BACKUP DATABASE @nombrebd TO DISK = @rutabackup
            
            return rutaBackup;
        }

        /*
        Para hacer el backup vamos a tener que hacer 3 pasos:
            1.  Cerrar conexiones activas
            2.	Restaurar la base de datos
            3.	Establecer la base de datos en modo multiusuario 
        Requisitos para que funcione
            - El usuario que ejecute el proceso debe tener permisos de administrador en SQL Server.
                - No es lo mismo ejecutar esta consulta desde el SSMS con un usuario administrador 
                    que desde la aplicación con un usuario con permisos limitados. 
                    En el segundo caso, es probable que se produzcan errores de permisos al 
                    intentar cerrar conexiones o restaurar la base de datos. 
            - Evitar usar el (localdb) en la cadena de conexión, ya que puede causar problemas de permisos. 
                En su lugar, usar el nombre del servidor SQL Server (por ejemplo, "localhost" o "NombreServidor").
        */
        public int RealizarRestaurarBackup(string rutaBackup)
        {
            // Asegúrate de que las rutas de destino sean carpetas donde SQL Server tenga permisos.
            // Ej: La carpeta DATA por defecto de SQL Server, o una carpeta pública como C:\BasesDeDatos\
            string rutaMdfDestino = @"C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\TpArqWeb.mdf";
            string rutaLdfDestino = @"C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\TpArqWeb_log.ldf";

            // 1. Cerrar conexiones activas y poner en modo usuario único
            int res = acceso.Escribir($"ALTER DATABASE [{NombreBD}] SET SINGLE_USER WITH ROLLBACK IMMEDIATE", null, false);

            // 2. Restaurar la base de datos
            string queryRestore = $@"
                USE MASTER; 
                RESTORE DATABASE [{NombreBD}] 
                FROM DISK = '{rutaBackup}' 
                WITH REPLACE,
                MOVE 'TpArqWeb' TO '{rutaMdfDestino}',
                MOVE 'TpArqWeb_log' TO '{rutaLdfDestino}'";

            res = acceso.Escribir(queryRestore, null, false);

            // 3. Devolver la base de datos a modo multiusuario
            res = acceso.Escribir($"ALTER DATABASE [{NombreBD}] SET MULTI_USER", null, false);

            return res;
        }
    }
}
