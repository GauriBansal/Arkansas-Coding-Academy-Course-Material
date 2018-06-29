using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BankWorm.Enums
{
    public static class EnumExtensions
    {
        public static TransactionType ConvertTransactionType(string transType)
        {
            if(transType == "Credit")
            {
                return TransactionType.Credit;
            }
            return TransactionType.Debit;
        }

        public static BankWorm.Data.TransactionTypes ConvertEFTransactionType(string transType)
        {
            if (transType == "Credit")
            {
                return BankWorm.Data.TransactionTypes.Credit;
            }
            return BankWorm.Data.TransactionTypes.Debit;
        }
    }
}
