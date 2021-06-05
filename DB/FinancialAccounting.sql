create table Transaction
					(TransactionID serial PRIMARY KEY
                    , Assets decimal
                    , Liabilities decimal  
                    , Equity decimal
                    , Income decimal
                    , Expense decimal
                    , Credit_SID integer
                    , Debit_SID integer
                    , Explanation text
                    , E_Hash_Credit varchar(64)
                    , E_Hash_Debit varchar(64)
                    );
                     
        insert into Transaction (TransactionID, Assets, Liabilities, Equity, Income, Expense) values (4, '70', '70', '70', '70', '70');
        insert into Transaction (TransactionID, Assets, Liabilities, Equity, Income, Expense) values (5, '70', '70', '70', '70', '70');
        insert into Transaction (TransactionID, Assets, Liabilities, Equity, Income, Expense) values (6, '70', '70', '70', '70', '70');
        
        
create table ServiceType
						(SType serial PRIMARY KEY
                        , Name varchar(64)
                         );
       insert into ServiceType (SType, Name) values (12, 'Jack');
       insert into ServiceType (SType, Name) values (13, 'James');
       insert into ServiceType (SType, Name) values (14, 'Jill');


create table Service
					(SID serial PRIMARY KEY
                     , Name varchar(64)
                     , ServiceType int
                     , Debit boolean
                     , Credit boolean
                     , Transaction boolean
                     , PID int 
                     , Explanation text
                     );
       insert into Service ( SID, Name, ServiceType, Debit, Credit, Transaction, PID, Explanation) values (1, 'Jill', '12', '1', '1', '1', '12', 'test');  
       insert into Service ( SID, Name, ServiceType, Debit, Credit, Transaction, PID, Explanation) values (2, 'Jack', '12', '1', '1', '1', '12', 'test'); 
       insert into Service ( SID, Name, ServiceType, Debit, Credit, Transaction, PID, Explanation) values (3, 'James', '12', '1', '1', '1', '12', 'test');
       
       
create table Product 
					(PID int PRIMARY KEY
                    , PType int
                    , Name varchar(64)
                    , Minimum decimal
                    );
       insert into Product (PID, PType, Name, Minimum) values (1, '420', 'Bryan', '.004');             
       insert into Product (PID, PType, Name, Minimum) values (2, '421', 'Feral', '.00480');       
       insert into Product (PID, PType, Name, Minimum) values (3, '422', 'Larry', '.00403');       
       
       
create table Entity 
                     (E_Hash varchar(64) PRIMARY KEY
                     ); 
                     
     insert into Entity (E_Hash) values (1);
     
     
create table Credit 
		    (TransactionID serial PRIMARY KEY
                    , Assets decimal
                    , Liabilities decimal  
                    , Equity decimal
                    , Income decimal
                    , Expense decimal
                    );
                     
        insert into Credit (TransactionID, Assets, Liabilities, Equity, Income, Expense) values (1, '70', '70', '70', '70', '70');
        insert into Credit (TransactionID, Assets, Liabilities, Equity, Income, Expense) values (2, '70', '70', '70', '70', '70');
        insert into Credit (TransactionID, Assets, Liabilities, Equity, Income, Expense) values (3, '70', '70', '70', '70', '70');
        
        
create table Balance 
					(BID serial PRIMARY KEY
                    , BType int
                    , Cash_Basis decimal
                    , Accrual_Basis bigint
                    , M_Hash varchar(64)
                    );
       insert into Balance (BID, BType, Cash_Basis, Accrual_Basis, M_Hash) values (1, '60', '1.40', '39', 'garage');
       insert into Balance (BID, BType, Cash_Basis, Accrual_Basis, M_Hash) values (5, '80', '1.40', '27', 'basement');
       insert into Balance (BID, BType, Cash_Basis, Accrual_Basis, M_Hash) values (7, '20', '1.40', '9', 'dungeon');
       
       
create table Debits (TransactionID serial Primary Key 
                     , Assets decimal
                     , Liabilities decimal
                     , Equity decimal
                     , Income decimal
                     , Expense decimal
                    );
                    
		insert into Debits (TransactionID, Assets, Liabilities, Equity, Income , Expense) values (1, 100.00, 100.00 , 50.00, 50.00, 1000.00 );
		insert into Debits (TransactionID, Assets,  Liabilities, Equity, Income , Expense) values (2, 350.00, 100.00 , 1000.00, 100.00, 2000.00);		
        ;



   
create table ProductType (
		      PType serial Primary Key 
                     , Name varchar(64)
                    );
                    
		insert into ProductType (PType, Name) values (1, 'John Doe');
		insert into ProductType (PType, Name) values (2,'Jane Doe');		



create table Product_Member (
		      PMID serial Primary Key 
                     ,PID int
		     ,M_hash varchar(64)
		     ,Balance decimal
                    );
                    
		insert into Product_Member (PMID,PID, M_hash,Balance ) values (1, 55, 'Hash1', 1000.00  );
		insert into Product_Member (PMID,PID, M_hash,Balance ) values (2, 33, 'Hash2', 2000.00  );



create table BalanceType (
		      Btype serial Primary Key 
                     ,Name varchar(255)
                    );
                    
		insert into BalanceType (BType,Name) values (1, 'Joe Johnson');
		insert into BalanceType (BType,Name) values (2, 'Jane Johnson');



Create Table Member (
  					M_Hash Varchar(64) PRIMARY KEY
  					);
                    insert into Member (M_Hash)  values ('MHash1');
                    insert into Member (M_Hash)  values ('MHash2');
                    
              
