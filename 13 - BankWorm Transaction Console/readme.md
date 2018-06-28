


## Objects 
### Customers
- CustomerNumber: External identifier for this customer account
- Name: The full name of the customer
- Email: The email address of the customer

### Accounts
- AccountNumber: External identifier for this account
- Type: Checking, Savings
- Name: The customer-provided name of the account (optional)
- Balance: The current available balance, computed from Transactions

### Transactions
- Amount: The amount of the transaction line item
- Memo: The memo supplied by the transaction merchant
- Date: The date of the transaction line item
- Type: Debit, Credit

## Requirements
### Customers
- Create new customers
- Search for existing customers, show all associated accounts with current balance
- Select a customer account for manipulation

### Accounts
- Open accounts for new and existing customers
  * Must have a Checking account to open a Savings account
  * Limit 2 Savings accounts per Customer
- Can only debit (withdrawal) from Savings account 3 times per month
- Overdraft fee is $15 on Checking account, and is $20 on Savings account. 

### Reports
- Show all Accounts with current balance 
- For a given account, supply all transactions by start/end date
