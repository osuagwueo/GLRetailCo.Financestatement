Create View vwGLTrans
-- this view contains all the information required to create financial statements
As

Select 
-- columns from factGltransaction table
trs.FactGLTranID,
Trs.GLTranAmount,
Trs.JournalID,
Trs.GLTranDescription,
Trs.GLTranDate,

---columns Gl accounts
Acct.AlternateKey as GlacctNum,
Acct.GLAcctName,
Acct.[Statement],
Acct.Category,
Acct.Subcategory,

--store columns
store.AlternateKey as StoreNum,
store.StoreName,
Store.ManagerID,
Store.PreviousManagerID,
store.ContactTel,
Store.AddressLine1,
Store.AddressLine2,
Store.ZipCode,

--region
region.AlternateKey as RegionNum,
Region.RegionName,
Region.SalesRegionName,


-- last refresh date
Convert ( datetime2, getdate() at time zone 'UTC' at time zone 'central standard Time') As LastRefreshDate 

 from FactGLTran as Trs 
left join dimGLAcct as Acct on Trs.GLAcctID = Acct.GLAcctID 
Left join dimStore as Store on Trs.StoreID =Store.StoreID
left join dimJournal as journal on trs.JournalID = journal.JournalID 
left join dimRegion as Region on Store.RegionID = Region.RegionID
Left join dimEmployee as Employee on  Store.ManagerID = Employee.EmployeeID 

/* to check for system timezone, this enables one refresh data based on the users timezone*/
--Select * from sys.time_zone_info