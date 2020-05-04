-- Connect 
\c vicentinaserramenti

-- Insert operations
INSERT INTO Seller VALUES ( 'carote@example.it', 'Paulo', 'Dybala');
INSERT INTO Seller VALUES ('mele@example.it','Mirko','Vucinic');
INSERT INTO Seller VALUES ('pineapple@example.com','Mario','Rossi');

INSERT INTO ExternalCollaborator VALUES ('13243546576', 'Antonio', 'Di Pietro');
INSERT INTO ExternalCollaborator VALUES ('10101215873', 'Andrea', 'Cervone');
INSERT INTO ExternalCollaborator VALUES ('97867564534','Andrea', 'Bargnani');

INSERT INTO MarketingCampaign VALUES ('Fantastic Windows', 3250.00, '[2018-01-01 00:01, 2018-05-30 23:59]');
INSERT INTO MarketingCampaign VALUES ('The bests', 2000.00, '[20.02.2019 00:00 , 20.04.2019 00:00)');
INSERT INTO MarketingCampaign VALUES ('other', 0, '[01.01.2017 00:00 , 31.12.2020 00:00)');

INSERT INTO Customer VALUES ('+391112200987','Ernesto','Luigini','Via Vai 8','ernestluis@test.com','The bests');
INSERT INTO Customer VALUES ('+393462004448', 'Willy', 'Coyote', 'Via Dotto 9', 'will@test.com', 'other');
INSERT INTO Customer VALUES ('0491426085','Ivana','Farisini','Via Lattea 15','ivanapagin@test.com','other');
INSERT INTO Customer VALUES ('0444392847','LeBron','James','Via Lemani 9','lbj@example.com','The bests');
INSERT INTO Customer VALUES ('+394329876054','Roberta','Ghidoni','Via Frasca 1','betty65@example.it','Fantastic Windows');
INSERT INTO Customer VALUES ('034726374','Enzo', 'Iacchetti', 'Via Pedale 12', 'enziach@example.com', 'Fantastic Windows');
INSERT INTO Customer VALUES ('0491518605','Jacopo','Salviato','Via Milano 12','jackisale@example.it','other');

INSERT INTO Quote VALUES (default,1200.00, 'https://www.google.it/', 'carote@example.it', '+391112200987', '20-01-2018');
INSERT INTO Quote VALUES (default,2500.00, 'https://www.nba.com', 'carote@example.it', '+393462004448', '21-02-2018');
INSERT INTO Quote VALUES (default,19000.50, 'https://www.realmadridbaloncesto.es/','carote@example.it', '0491426085', '22-09-2018');
INSERT INTO Quote VALUES (default,120333.00, 'https://www.google.it/' ,'mele@example.it','0444392847', '23-04-2018');
INSERT INTO Quote VALUES (default,9000.00,'https://www.google.it/','mele@example.it', '+394329876054', '06-07-2019');
INSERT INTO Quote VALUES (default,8500.00, 'https://www.google.it/', 'pineapple@example.com', '034726374', '13-11-2019');
INSERT INTO Quote VALUES (default,20000.00, '', 'mele@example.it', '0491518605', '15-12-2019');

INSERT INTO JobOrder VALUES (1,'20-02-2018', 'https://www.google.it/', '20-04-2018');
INSERT INTO JobOrder VALUES (2,'15-03-2018', 'https://www.google.it/', '15-05-2018');
INSERT INTO JobOrder VALUES (3,'15-03-2018', 'https://www.google.it/', '07-05-2018');
INSERT INTO JobOrder VALUES (4,'29-06-2018', 'https://www.google.it/', '01-07-2018');
INSERT INTO JobOrder VALUES (5,'15-07-2018', 'https://www.google.it/', '05-09-2018');
INSERT INTO JobOrder VALUES (6,'09-04-2019', 'https://www.google.it/', '29-06-2019');
INSERT INTO JobOrder VALUES (7,'20-02-2019', 'https://www.google.it/', '20-05-2019');

INSERT INTO WarrantyReport VALUES (default,'https://bootstrapious.com/p/bootstrap-sidebar', 'https://www.google.it/', 1);
INSERT INTO WarrantyReport VALUES (default,'https://www.live.com/', 'https://www.google.it/', 2);
INSERT INTO WarrantyReport VALUES (default,'https://www.long.it/docs', 'https://www.google.it/', 3);
INSERT INTO WarrantyReport VALUES (default,'https://www.vicolocieco.es/documents', 'https://www.google.it/', 4);
INSERT INTO WarrantyReport VALUES (default,'https://www.www.ww/docs', 'https://www.google.it/', 5);
INSERT INTO WarrantyReport VALUES (default,'https://bootstrapious.com/p/bootstrap-sidebar', 'https://www.google.it/', 6);

INSERT INTO Supplier VALUES ('98075643209', 'Flamarlegno');
INSERT INTO Supplier VALUES ('12309856743', 'Windows AC Milan');
INSERT INTO Supplier VALUES ('00998877765', 'Best windows');

INSERT INTO Material VALUES ('1234569870','Window blue','Blue window for Roberta');
INSERT INTO Material VALUES ('9087060590', 'Door white', 'This is a white door for indoor');
INSERT INTO Material VALUES ('3210984567', 'Gold handle', 'Indoor gold handle');
INSERT INTO Material VALUES ('1627384950', 'Window dark brown','Front house outdoor window'); 

INSERT INTO Contacted VALUES ('+393462004448', 'The bests',true);
INSERT INTO Contacted VALUES ('034726374', 'Fantastic Windows', false);
INSERT INTO Contacted VALUES ('0491426085', 'other', true);
INSERT INTO Contacted VALUES ('0491518605', 'other', true);
INSERT INTO Contacted VALUES ('+393462004448', 'Fantastic Windows', true);

INSERT INTO IsFulfilledBy VALUES ('13243546576', 1, 40, 7);
INSERT INTO IsFulfilledBy VALUES ('10101215873', 1, 24, 7);
INSERT INTO IsFulfilledBy VALUES ('13243546576', 2, 39, 7);
INSERT INTO IsFulfilledBy VALUES ('97867564534', 3, 20, 9);
INSERT INTO IsFulfilledBy VALUES ('97867564534', 5, 13, 7);
INSERT INTO IsFulfilledBy VALUES ('10101215873', 6, 14, 9);

INSERT INTO Purchased VALUES (1, '98075643209', '1234569870', 3, 150.00, 'https://www.vicolocieco.es/documents');
INSERT INTO Purchased VALUES (1, '12309856743', '9087060590', 5, 370.00, 'https://www.www.ww/docs');
INSERT INTO Purchased VALUES (2, '12309856743', '3210984567', 2, 110.50, 'google.cos/thisinopportunity/docs');
INSERT INTO Purchased VALUES (3, '98075643209', '1627384950', 10, 1200.00, 'https://www.parcoacquatico.lol');
