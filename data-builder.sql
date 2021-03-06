
--IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'knapsack')
--BEGIN
--CREATE DATABASE [knapsack];
--END
--GO


--USE [knapsack]
--GO

-- database table should be inserted here
DROP TABLE IF EXISTS dbo.TypesItems;
GO
CREATE TABLE dbo.TypesItems (
    [idType] INT IDENTITY(1,1) PRIMARY KEY,
    [nomType] VARCHAR(20) NOT NULL
);
GO

DROP TABLE IF EXISTS dbo.Items;
GO
CREATE TABLE dbo.Items (
    [idItem] INT IDENTITY(1,1) PRIMARY KEY,
    [nom] VARCHAR(50) NOT NULL,
    [idType] SMALLINT NOT NULL,
    [prix] MONEY NOT NULL,
    [poid] NUMERIC(5,1) NOT NULL,
    [urlImage] VARCHAR(500) NOT NULL,
    [qte] INT NOT NULL DEFAULT 0,
    [disponibilite] BIT DEFAULT 1,
    [description] VARCHAR(500),

    CONSTRAINT fk_Items_TypesItems FOREIGN KEY ([idItem]) 
        REFERENCES [dbo].[TypesItems]([idType]),
    CONSTRAINT ck_Items_qte CHECK ([qte] >= 0),
);
GO

DROP TABLE IF EXISTS dbo.TypesArmes;
GO
CREATE TABLE dbo.TypesArmes (
    idType INT IDENTITY(1,1) PRIMARY KEY,
    nom VARCHAR(25) NOT NULL,
);
GO

DROP TABLE IF EXISTS dbo.Armes;
GO
CREATE TABLE dbo.Armes (
    [idItem] INT PRIMARY KEY,
    [efficacite] INT NOT NULL,
    [type] INT NOT NULL,

    CONSTRAINT fk_Armes_Items FOREIGN KEY (idItem)
        REFERENCES Items(idItem),
    CONSTRAINT fk_Armes_TypesArmes FOREIGN KEY (type)
        REFERENCES TypesArmes(idType),
    CONSTRAINT ck_Armes_efficacite CHECK (efficacite >= 0),
);
GO

DROP TABLE IF EXISTS dbo.Medicaments;
GO
CREATE TABLE dbo.Medicaments (
    idItem INT PRIMARY KEY,
    effetAttendu VARCHAR(50) NOT NULL,
    dureeEffet INT NOT NULL,

    CONSTRAINT fk_Medicaments_Items FOREIGN KEY (idItem)
        REFERENCES Items(idItem),
);
GO

DROP TABLE IF EXISTS dbo.Armures;
GO
CREATE TABLE dbo.Armures (
    idItem INT PRIMARY KEY,
    matiere VARCHAR(50) NOT NULL,
    taille INT NOT NULL,

    CONSTRAINT fk_Armures_Items FOREIGN KEY (idItem)
        REFERENCES Items(idItem),
);
GO

DROP TABLE IF EXISTS dbo.Joueurs;
GO
CREATE TABLE dbo.Joueurs (
    idJoueur INT IDENTITY(1,1) PRIMARY KEY,
    password VARBINARY(256) NOT NULL,
    alias VARCHAR(25) NOT NULL UNIQUE,
    dexterite INT NOT NULL,
    poidMaximale INT NOT NULL,
    montantCaps MONEY NOT NULL,
    isAdmin BIT NOT NULL DEFAULT 0,
);
GO

DROP TABLE IF EXISTS dbo.Munitions;
GO
CREATE TABLE dbo.Munitions (
    idItem INT PRIMARY KEY,
    typeArme INT NOT NULL,

    CONSTRAINT fk_Munitions_TypesArmes FOREIGN KEY (typeArme)
        REFERENCES TypesArmes(idType),
    CONSTRAINT fk_Munitions_Items FOREIGN KEY (idItem)
        REFERENCES Items(idItem),
);
GO

DROP TABLE IF EXISTS dbo.Sacs;
GO
CREATE TABLE dbo.Sacs (
    idJoueur INT PRIMARY KEY,
    qteItem INT NOT NULL,
    idItem INT NOT NULL,

    CONSTRAINT fk_Sacs_Joueurs FOREIGN KEY (idJoueur)
        REFERENCES Joueurs(idJoueur),
    CONSTRAINT fk_Sacs_Items FOREIGN KEY (idItem)
        REFERENCES Items(idItem),
);
GO

DROP TABLE IF EXISTS dbo.Paniers;
GO
CREATE TABLE dbo.Paniers (
    idJoueur INT PRIMARY KEY,
    idItem INT NOT NULL,
    qteItem INT NOT NULL,

    CONSTRAINT fk_Paniers_Joueurs FOREIGN KEY (idJoueur)
        REFERENCES Joueurs(idJoueur),
    CONSTRAINT fk_Paniers_Items FOREIGN KEY (idItem)
        REFERENCES Items(idItem),
);
GO

DROP TABLE IF EXISTS dbo.Transactions;
GO
CREATE TABLE dbo.Transactions (
    idJoueur INT PRIMARY KEY,
    montant MONEY NOT NULL,

    CONSTRAINT fk_Transactions_Joueurs FOREIGN KEY (idJoueur)
        REFERENCES Joueurs(idJoueur),
);
GO

DROP TABLE IF EXISTS dbo.Collections;
GO
CREATE TABLE dbo.Collections (
    idJoueur INT NOT NULL,
    idItem INT NOT NULL,

    CONSTRAINT fk_Collections_Joueurs FOREIGN KEY (idJoueur)
        REFERENCES Joueurs(idJoueur),
    CONSTRAINT fk_Collections_Items FOREIGN KEY (idItem)
        REFERENCES Items(idItem),
);
GO

DROP TABLE IF EXISTS dbo.Ratings;
GO
CREATE TABLE dbo.Ratings (
    idJoueur INT NOT NULL,
    rating INT NOT NULL DEFAULT 1,
    idItem INT NOT NULL,
    commentaire VARCHAR(250),

    CONSTRAINT pk_Ratings PRIMARY KEY (idJoueur, idItem),
    CONSTRAINT ck_Ratings_rating 
        CHECK (rating <= 5 AND rating >= 1),
);
GO
