using DAL.BACKUP;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.BACKUP
{
    public class BLL_BACKUP
    {
        DAL_BACKUP dalbackup = new DAL_BACKUP();

        public string CrearBackup()
        {
            return dalbackup.RealizarBackup();
        }

        public int RestaurarBackup(string ruta)
        {
            return dalbackup.RealizarRestaurarBackup(ruta);
        }
    }
}
