using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using BankWorm.Data;
using BankWorm.Enums;

namespace BankWorm.Services
{
    public class EFCustomerService
    {
        private readonly BankWormEntities _context;

        public EFCustomerService()
        {
            _context = new BankWormEntities();
        }

        //method for eager loading (Include) and lazy loading (remove Include) concept
        public void Test()
        {
            var customers = _context
                            .Customers
                            .Include(c => c.Accounts.Select(a => a.Transactions))  //for eager loading
                            .ToList();

            var breakPoint = "";

            foreach(var c in customers)
            {
                var test = c.Accounts;
            }
        }

        public void ReadFile(Account account1)
        {
            var fileName1 = "C:\\Source\\acadotnet\\BankWorm\\transactionfile-data.csv";

            var fileContents = File.ReadAllLines(fileName1).ToList().Skip(1);
            foreach (var line in fileContents)
            {
                var cells = line.Split(',');

                var transaction = new Transaction
                {
                    CreateDate = DateTime.Parse(cells[0]),
                    Memo = cells[1],
                    TransactionTypeId = EnumExtensions.ConvertEFTransactionType(cells[2]),
                    Amount = Convert.ToDecimal(cells[3]),
                    Account = account1
                };
                _context.Transactions.Add(transaction);
            }
            _context.SaveChanges();
        }

        public Account CreateCustomer(string name, string email, string acctName, AccountTypes aType)
        {

            var isCustomerFound = _context.Customers.Any(c => (c.Name == name) && (c.Email == email));

            if (isCustomerFound)
            {
                var account = _context.Customers.FirstOrDefault(c => (c.Name == name) && (c.Email == email))
                                      .Accounts.FirstOrDefault(a => a.AccountTypeId == aType);
                return account;
            }

            var customer1 = new Customer
            {
                Name = name,
                Email = email,
                CreateDate = DateTime.UtcNow
            };

            var account1 = new Account
            {
                Name = acctName,
                AccountTypeId = aType
            };

            customer1.Accounts.Add(account1);

            //var p = _context.Customers.FirstOrDefault(c => c.Id == 1);
            //p.Name = "Gauri Goyal Bansal";

            _context.Customers.Add(customer1);

            _context.SaveChanges();

            return account1;
            //var customers = _context.Customers.ToList();
        }
    }
}
