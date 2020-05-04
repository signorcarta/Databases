-- domain that perform a simple check on syntax of emails
CREATE DOMAIN EMAIL AS VARCHAR(50) CHECK(
(VALUE)::text~*'^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'::text);

-- Table creation
CREATE TABLE Seller(
  email EMAIL,
  name VARCHAR(50) NOT NULL,
  surname VARCHAR(50) NOT NULL,
  PRIMARY KEY(email)
);

CREATE TABLE ExternalCollaborator(
  vat VARCHAR(15),
  name VARCHAR(50) NOT NULL,
  surname VARCHAR(50) NOT NULL,
  PRIMARY KEY(vat)
);

CREATE TABLE MarketingCampaign(
  name VARCHAR(50),
  cost NUMERIC(10,2) CHECK(cost>=0 OR NULL),
  period DATERANGE,
  PRIMARY KEY(name)
);

CREATE TABLE Customer(
  telephone VARCHAR(20),
  name VARCHAR(50) NOT NULL,
  surname VARCHAR(50) NOT NULL,
  address VARCHAR(150) NOT NULL,
  email EMAIL,
  firstContact VARCHAR(50),
  PRIMARY KEY(telephone),
  FOREIGN KEY (firstContact) REFERENCES MarketingCampaign(name)
);

CREATE TABLE Quote(
  id SERIAL,
  totalPrice NUMERIC(10,2) NOT NULL CHECK(totalPrice>=0),
  descriptivePDF TEXT NOT NULL,
  email EMAIL NOT NULL,
  telephone VARCHAR(20) NOT NULL,
  requestDate DATE NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY (telephone) REFERENCES Customer(telephone),
  FOREIGN KEY (email) REFERENCES Seller(email)
);

CREATE TABLE JobOrder(
  id INTEGER,
  contractDate DATE NOT NULL,
  clientInvoice TEXT,
  deliveryDate DATE,
  PRIMARY KEY(id),
  FOREIGN KEY (id) REFERENCES Quote(id),
  CHECK (deliveryDate>contractDate)
);

CREATE TABLE WarrantyReport(
  code SERIAL,
  picture TEXT NOT NULL,
  pdf TEXT NOT NULL,
  jobOrderId INTEGER NOT NULL,
  PRIMARY KEY(code),
  FOREIGN KEY (jobOrderId) REFERENCES JobOrder(id)
);

CREATE TABLE Supplier(
  vat VARCHAR(15),
  companyName VARCHAR(50) NOT NULL,
  PRIMARY KEY(vat)
);

CREATE TABLE Material(
  productCode VARCHAR(50),
  name VARCHAR(50) NOT NULL,
  description TEXT,
  PRIMARY KEY (productCode) 
);

CREATE TABLE Contacted(
  telephone VARCHAR(20),
  name VARCHAR(50),
  customerFeedback BOOLEAN DEFAULT FALSE NOT NULL, 
  PRIMARY KEY (telephone, name),
  FOREIGN KEY (telephone) REFERENCES Customer(telephone),
  FOREIGN KEY (name) REFERENCES MarketingCampaign(name)
);

CREATE TABLE IsFulfilledBy(
  vat VARCHAR(15),
  id INTEGER,
  workingHours FLOAT,
  costPerHours FLOAT NOT NULL CHECK(costPerHours>=0),
  PRIMARY KEY (vat, id),
  FOREIGN KEY (vat) REFERENCES ExternalCollaborator(vat),
  FOREIGN KEY (id) REFERENCES JobOrder(id)
);

CREATE TABLE Purchased(
  id INTEGER,
  vat VARCHAR(15),
  productCode VARCHAR(50),
  quantity INTEGER NOT NULL,
  cost NUMERIC(10,2) NOT NULL CHECK(cost>=0),
  supplierInvoice TEXT,
  PRIMARY KEY(id, vat, productCode),
  FOREIGN KEY (id) REFERENCES JobOrder(id),
  FOREIGN KEY (vat) REFERENCES Supplier(vat),
  FOREIGN KEY (productCode) REFERENCES Material(productCode)
);
