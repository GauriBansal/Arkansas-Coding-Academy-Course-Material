namespace BankWorm.CodeFirst.Migrations
{
    using BankWorm.CodeFirst.Models;
    using System;
    using System.Collections.Generic;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;

    internal sealed class Configuration : DbMigrationsConfiguration<BankWorm.CodeFirst.BankWormContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }

        protected override void Seed(BankWorm.CodeFirst.BankWormContext context)
        {
            //  This method will be called after migrating to the latest version.

            //  You can use the DbSet<T>.AddOrUpdate() helper extension method 
            //  to avoid creating duplicate seed data.
            var gauri = new Customer
            {
                Name = "Gauri Bansal",
                Accounts = new List<Account>
                {
                    new Account
                    {
                        Name = "Checkings",
                        AccountType = AccountType.Checking,
                        AccountOpenedDate = DateTime.Now
                    }
                }
            };

            context.Customers.AddOrUpdate(gauri);
        }
    }
}
