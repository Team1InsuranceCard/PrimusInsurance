USE [master]
GO
/****** Object:  Database [InsuranceCard]    Script Date: 13/01/2022 08:49:42 ******/
CREATE DATABASE [InsuranceCard]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BikeSure', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BikeSure.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BikeSure_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BikeSure_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [InsuranceCard] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [InsuranceCard].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [InsuranceCard] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [InsuranceCard] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [InsuranceCard] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [InsuranceCard] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [InsuranceCard] SET ARITHABORT OFF 
GO
ALTER DATABASE [InsuranceCard] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [InsuranceCard] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [InsuranceCard] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [InsuranceCard] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [InsuranceCard] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [InsuranceCard] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [InsuranceCard] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [InsuranceCard] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [InsuranceCard] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [InsuranceCard] SET  DISABLE_BROKER 
GO
ALTER DATABASE [InsuranceCard] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [InsuranceCard] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [InsuranceCard] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [InsuranceCard] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [InsuranceCard] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [InsuranceCard] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [InsuranceCard] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [InsuranceCard] SET RECOVERY FULL 
GO
ALTER DATABASE [InsuranceCard] SET  MULTI_USER 
GO
ALTER DATABASE [InsuranceCard] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [InsuranceCard] SET DB_CHAINING OFF 
GO
ALTER DATABASE [InsuranceCard] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [InsuranceCard] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [InsuranceCard] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [InsuranceCard] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'InsuranceCard', N'ON'
GO
ALTER DATABASE [InsuranceCard] SET QUERY_STORE = OFF
GO
USE [InsuranceCard]
GO
/****** Object:  Table [dbo].[Accident]    Script Date: 13/01/2022 08:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accident](
	[ID] [int] NOT NULL,
	[AccidentDate] [datetime] NULL,
	[Title] [nvarchar](600) NULL,
	[CreatedDate] [datetime] NULL,
	[Attachment] [varbinary](max) NULL,
	[HumanDamage] [ntext] NULL,
	[VehicleDamage] [ntext] NULL,
	[CompensationID] [int] NULL,
 CONSTRAINT [PK_Accident] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 13/01/2022 08:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[ID] [int] NOT NULL,
	[Email] [nchar](300) NOT NULL,
	[Password] [varbinary](64) NULL,
	[Role] [bit] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Compensation]    Script Date: 13/01/2022 08:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Compensation](
	[ID] [int] NOT NULL,
	[DriverName] [nvarchar](600) NULL,
	[CreatedDate] [datetime] NULL,
	[ResolveDate] [datetime] NULL,
	[ResolveNote] [ntext] NULL,
	[Decision] [bit] NULL,
	[Description] [ntext] NULL,
	[Attachment] [varbinary](max) NULL,
	[ContractID] [int] NULL,
 CONSTRAINT [PK_Compensation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contract]    Script Date: 13/01/2022 08:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contract](
	[ID] [int] NOT NULL,
	[ProductID] [int] NULL,
	[CustomerID] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[Status] [smallint] NULL,
	[isDelete] [bit] NULL,
	[ContractFee] [money] NULL,
	[CancelComment] [nvarchar](600) NULL,
	[CancelReason] [nvarchar](600) NULL,
	[CancelDate] [datetime] NULL,
	[CancelRequestDate] [datetime] NULL,
	[VehicleType] [nvarchar](300) NULL,
	[Engine] [nvarchar](100) NULL,
	[LicensePlate] [nchar](100) NULL,
	[Color] [nchar](100) NULL,
	[CertImage] [varbinary](max) NULL,
	[Brand] [nchar](100) NULL,
	[Owner] [nvarchar](600) NULL,
	[Chassis] [nchar](100) NULL,
	[RequestDate] [datetime] NULL,
	[ResolveDate] [datetime] NULL,
 CONSTRAINT [PK_Contract] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 13/01/2022 08:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](300) NULL,
	[LastName] [nvarchar](300) NULL,
	[Address] [nvarchar](600) NULL,
	[Dob] [date] NULL,
	[JoinDate] [nchar](10) NULL,
	[StaffID] [int] NULL,
	[Phone] [nchar](15) NULL,
	[PersonalID] [nchar](15) NULL,
	[Province] [nvarchar](100) NULL,
	[District] [nvarchar](100) NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer_Staff]    Script Date: 13/01/2022 08:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer_Staff](
	[CustomerID] [int] NOT NULL,
	[StaffID] [int] NOT NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[NextStaff] [int] NULL,
 CONSTRAINT [PK_Customer_Staff] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC,
	[StaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Moderator]    Script Date: 13/01/2022 08:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Moderator](
	[ID] [int] NOT NULL,
	[UserName] [nchar](100) NULL,
	[Password] [binary](64) NULL,
 CONSTRAINT [PK_Moderator] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NewContractRequest]    Script Date: 13/01/2022 08:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewContractRequest](
	[ID] [nchar](10) NULL,
	[Title] [nchar](10) NULL,
	[RequestDate] [nchar](10) NULL,
	[ResolveDate] [nchar](10) NULL,
	[Note] [nchar](10) NULL,
	[isDelete] [nchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 13/01/2022 08:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[ID] [int] NOT NULL,
	[PaidDate] [datetime] NULL,
	[PaymentMethod] [nchar](300) NULL,
	[Note] [nchar](600) NULL,
	[Amout] [money] NULL,
	[StartDate] [nchar](10) NULL,
	[ContractID] [int] NULL,
 CONSTRAINT [PK_Payment] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 13/01/2022 08:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](300) NULL,
	[Description] [nvarchar](300) NULL,
	[Price] [money] NULL,
	[ImageURL] [nchar](300) NULL,
	[Status] [smallint] NULL,
	[isDelete] [bit] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 13/01/2022 08:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[ID] [int] NOT NULL,
	[FirstName] [nvarchar](300) NULL,
	[LastName] [nvarchar](300) NULL,
	[Phone] [nchar](15) NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Staff] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Accident] ADD  CONSTRAINT [DF_Accident_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF_Account_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Compensation] ADD  CONSTRAINT [DF_Compensation_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Contract] ADD  CONSTRAINT [DF_Contract_isDelete]  DEFAULT ((0)) FOR [isDelete]
GO
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF_Customer_JoinDate]  DEFAULT (getdate()) FOR [JoinDate]
GO
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF_Customer_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Customer_Staff] ADD  CONSTRAINT [DF_Customer_Staff_StartDate]  DEFAULT (getdate()) FOR [StartDate]
GO
ALTER TABLE [dbo].[Payment] ADD  CONSTRAINT [DF_Payment_StartDate]  DEFAULT (N'getDate') FOR [StartDate]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_isDelete]  DEFAULT ((0)) FOR [isDelete]
GO
ALTER TABLE [dbo].[Staff] ADD  CONSTRAINT [DF_Staff_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Accident]  WITH CHECK ADD  CONSTRAINT [FK_Accident_Compensation] FOREIGN KEY([CompensationID])
REFERENCES [dbo].[Compensation] ([ID])
GO
ALTER TABLE [dbo].[Accident] CHECK CONSTRAINT [FK_Accident_Compensation]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Staff] FOREIGN KEY([ID])
REFERENCES [dbo].[Staff] ([ID])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Staff]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Account] FOREIGN KEY([ID])
REFERENCES [dbo].[Customer] ([ID])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Customer_Account]
GO
ALTER TABLE [dbo].[Compensation]  WITH CHECK ADD  CONSTRAINT [FK_Compensation_Contract] FOREIGN KEY([ContractID])
REFERENCES [dbo].[Contract] ([ID])
GO
ALTER TABLE [dbo].[Compensation] CHECK CONSTRAINT [FK_Compensation_Contract]
GO
ALTER TABLE [dbo].[Contract]  WITH CHECK ADD  CONSTRAINT [FK_Contract_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([ID])
GO
ALTER TABLE [dbo].[Contract] CHECK CONSTRAINT [FK_Contract_Customer]
GO
ALTER TABLE [dbo].[Contract]  WITH CHECK ADD  CONSTRAINT [FK_Contract_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
GO
ALTER TABLE [dbo].[Contract] CHECK CONSTRAINT [FK_Contract_Product]
GO
ALTER TABLE [dbo].[Customer_Staff]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Staff_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([ID])
GO
ALTER TABLE [dbo].[Customer_Staff] CHECK CONSTRAINT [FK_Customer_Staff_Customer]
GO
ALTER TABLE [dbo].[Customer_Staff]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Staff_Staff] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([ID])
GO
ALTER TABLE [dbo].[Customer_Staff] CHECK CONSTRAINT [FK_Customer_Staff_Staff]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Contract] FOREIGN KEY([ContractID])
REFERENCES [dbo].[Contract] ([ID])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_Payment_Contract]
GO
USE [master]
GO
ALTER DATABASE [InsuranceCard] SET  READ_WRITE 
GO
