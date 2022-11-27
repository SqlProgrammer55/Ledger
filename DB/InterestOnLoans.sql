

POST GRES SQL;
Create View [111_InterestFromLoans_Total] AS

sum(
	111_1_BizLoanInterest.interestamt + 
	111_2_AgriLoanInterest.interestamt +
	111_3_ConsumerLoanInterest.interestamt +
	111_4_MobileHomeLoanInterest.interestamt +
	111_5_SharedSecuredInsuredLoanInterest.interestamt +
	111_6_OtherMemberLoanInterest.interestamt +
	111_7_HomeEquityLoansInterest.interestamt 
	)
	
	From Table 1
	Left join table 2 on id
	Left join table 3 on id
	Left join table 4 on id
	Left join table 5 on id
	Left join table 6 on id
	Left join table 7 on id  ; 

INSERT INTO 111_1_BizLoanInterest(interestamt , column2, …) 
VALUES (100, value2, …) ;

INSERT INTO 111_2_AgriLoanInterest (interestamt , column2, …) 
VALUES (100, value2, …) ;

INSERT INTO 111_3_ConsumerLoanInterest (interestamt , column2, …) 
VALUES (100, value2, …);

INSERT INTO 111_4_MobileHomeLoanInterest (interestamt , column2, …) 
VALUES (100, value2, …);

INSERT INTO 111_5_SharedSecuredInsuredLoanInterest (interestamt , column2, …) 
VALUES (100, value2, …);

INSERT INTO 111_6_OtherMemberLoanInterest (interestamt , column2, …) 
VALUES (100, value2, …);

INSERT INTO 111_7_HomeEquityLoansInterest (interestamt , column2, …) 
VALUES (100, value2, …);
