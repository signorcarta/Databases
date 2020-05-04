--Allows to recover the quantities of materials purchased from a supplier and the expenditure incurred during a year (e.g. 2018) 

SELECT S.companyName AS companyName, M.name AS name, quantity, totalCost
FROM 
  (SELECT P.vat, P.productCode, SUM(P.quantity) AS quantity,  SUM(P.quantity*P.cost) AS totalCost
    FROM JobOrder J INNER JOIN Purchased P ON  P.id = J.id
    WHERE  '[2017-01-01,2019-12-31]'::daterange @> J.contractDate
    GROUP BY P.vat, P.productCode) AS G
  INNER JOIN Supplier S ON S.vat=G.vat
  INNER JOIN  Material M ON M.productCode = G.productCode
ORDER BY S.companyName;


--Allows to retrieve contact information to carry out corporate marketing campaigns aimed at a group of customers
SELECT DISTINCT C.Name AS name, C.Surname AS surname, C.Address AS address, C.telephone AS telephone, C.email AS email
  FROM Customer C INNER JOIN Quote Q ON C.telephone = Q.telephone
    INNER JOIN  JobOrder J ON Q.id = J.id
    INNER JOIN Purchased P ON P.id = J.id
      INNER JOIN Material M ON M.productCode = P.productCode
  WHERE lower(M.Name) LIKE '%window%' OR lower(M.Name) LIKE '%door%';

--Allows to get a statistical report of each marketing campaign or how many customers have been touched by each campaign and have requested a quote

SELECT M.name as name, COUNT(*) as total
FROM MarketingCampaign M INNER JOIN Contacted Co ON M.name = Co.name
  INNER JOIN Customer Cu ON Cu.telephone = Co.telephone
  INNER JOIN Quote Q ON Q.telephone = Cu.telephone
WHERE Co.customerFeedback AND (M.period @>  Q.requestDate)
GROUP BY M.name;


-- Allows to retrieve data useful to draw up the periodic balance sheets of the company, i.e. expenditure on materials, labour (expenditure) and the price of the estimate paid by the customer (income)

SELECT SUM(P.quantity*P.cost) AS totalCostMaterials, 
  SUM(F.workingHours*F.costPerHours) AS totalCostExternalCollaborator, 
  SUM(Q.totalPrice) AS totalIncome
  FROM Purchased P INNER JOIN JobOrder J ON P.id=J.id
    INNER JOIN isFulFilledBy F ON F.id = J.id
    INNER JOIN ExternalCollaborator E ON E.vat = F.vat
    INNER JOIN Quote Q ON Q.id = J.id 
  WHERE '[2018-01-01,2019-12-31]'::daterange @> J.deliveryDate;

SELECT SUM(cost) AS totalCostMarketing
FROM MarketingCampaign
WHERE '[2018-01-01,2019-12-31]'::daterange @> period;
