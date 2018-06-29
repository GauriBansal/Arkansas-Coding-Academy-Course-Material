using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BankWorm.CodeFirst.Models
{
    public class Account
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public Customer Customer { get; set; }

        public AccountType AccountType { get; set; }

        public DateTime AccountOpenedDate { get; set; }
    }
}
