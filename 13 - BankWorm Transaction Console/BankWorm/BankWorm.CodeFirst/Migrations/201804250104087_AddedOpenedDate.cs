namespace BankWorm.CodeFirst.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddedOpenedDate : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Accounts", "AccountOpenedDate", c => c.DateTime(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Accounts", "AccountOpenedDate");
        }
    }
}
