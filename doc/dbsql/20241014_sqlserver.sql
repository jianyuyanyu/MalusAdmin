USE [master]
GO
/****** Object:  Database [MalusAdminTest]    Script Date: 2024/10/14 16:03:40 ******/
CREATE DATABASE [MalusAdminTest]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MalusAdminTest', FILENAME = N'/var/opt/mssql/data/MalusAdminTest.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MalusAdminTest_log', FILENAME = N'/var/opt/mssql/data/MalusAdminTest_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [MalusAdminTest] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MalusAdminTest].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MalusAdminTest] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MalusAdminTest] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MalusAdminTest] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MalusAdminTest] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MalusAdminTest] SET ARITHABORT OFF 
GO
ALTER DATABASE [MalusAdminTest] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MalusAdminTest] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MalusAdminTest] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MalusAdminTest] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MalusAdminTest] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MalusAdminTest] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MalusAdminTest] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MalusAdminTest] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MalusAdminTest] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MalusAdminTest] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MalusAdminTest] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MalusAdminTest] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MalusAdminTest] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MalusAdminTest] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MalusAdminTest] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MalusAdminTest] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MalusAdminTest] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MalusAdminTest] SET RECOVERY FULL 
GO
ALTER DATABASE [MalusAdminTest] SET  MULTI_USER 
GO
ALTER DATABASE [MalusAdminTest] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MalusAdminTest] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MalusAdminTest] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MalusAdminTest] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MalusAdminTest] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MalusAdminTest] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [MalusAdminTest] SET QUERY_STORE = ON
GO
ALTER DATABASE [MalusAdminTest] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [MalusAdminTest]
GO
/****** Object:  Table [dbo].[bs_bingwallpaper]    Script Date: 2024/10/14 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_bingwallpaper](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CopyRight] [nvarchar](max) NULL,
	[GitUrl] [nvarchar](max) NULL,
	[MobileUrl] [nvarchar](max) NULL,
	[Url] [nvarchar](max) NULL,
	[StartDate] [date] NOT NULL,
	[CreatedTime] [datetimeoffset](7) NULL,
	[UpdatedTime] [datetimeoffset](7) NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](20) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_bs_bingwallpaper] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_bs_bingwallpaper_startdate] UNIQUE NONCLUSTERED 
(
	[StartDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_customer]    Script Date: 2024/10/14 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_customer](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[OpenID] [varchar](200) NOT NULL,
	[NickName] [varchar](200) NOT NULL,
	[RealName] [varchar](200) NULL,
	[AvatarUrl] [varchar](200) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_bs_customer_UserID] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_gallery]    Script Date: 2024/10/14 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_gallery](
	[ImagesID] [int] IDENTITY(1,1) NOT NULL,
	[ImagesURL] [varchar](255) NOT NULL,
	[ImagesWide] [decimal](18, 4) NOT NULL,
	[ImagesHeiget] [decimal](18, 4) NOT NULL,
	[ImagesSize] [decimal](18, 4) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[VerticalScreen] [bit] NOT NULL,
	[Source] [nvarchar](100) NULL,
	[Examine] [int] NULL,
	[UpdateTime] [datetime] NULL,
	[IsDelete] [bit] NULL,
	[Praise] [int] NULL,
	[Dislike] [int] NULL,
 CONSTRAINT [PK_bs_gallery_ImagesID] PRIMARY KEY CLUSTERED 
(
	[ImagesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_miniappsitelink]    Script Date: 2024/10/14 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_miniappsitelink](
	[MiniAppSiteLinkId] [int] IDENTITY(1,1) NOT NULL,
	[MiniAppId] [varchar](200) NOT NULL,
	[MiniAppUrl] [varchar](200) NOT NULL,
	[MiniAppName] [varchar](200) NOT NULL,
	[Path] [varchar](200) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_bs_miniappsitelink_MiniAppSiteLinkId] PRIMARY KEY CLUSTERED 
(
	[MiniAppSiteLinkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_wechatconfig]    Script Date: 2024/10/14 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_wechatconfig](
	[WechatAppID] [varchar](200) NOT NULL,
	[WechatAppSecret] [varchar](200) NOT NULL,
	[WechatAppName] [varchar](200) NOT NULL,
	[AccessToken] [varchar](200) NOT NULL,
	[ExpireTime] [int] NOT NULL,
	[UpTime] [datetime] NOT NULL,
	[NextUpTime] [datetime] NOT NULL,
	[Res] [varchar](200) NOT NULL,
 CONSTRAINT [PK_bs_wx_config_WechatAppID] PRIMARY KEY CLUSTERED 
(
	[WechatAppID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_sys_config]    Script Date: 2024/10/14 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_sys_config](
	[ConfigID] [int] IDENTITY(1,1) NOT NULL,
	[ConfigKey] [nvarchar](50) NULL,
	[ConfigType] [nvarchar](50) NULL,
	[ConfigValue] [nvarchar](max) NULL,
	[ConfigDescribe] [nvarchar](200) NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_bs_webconfig] PRIMARY KEY CLUSTERED 
(
	[ConfigID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_sys_menu]    Script Date: 2024/10/14 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_sys_menu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParentId] [int] NOT NULL,
	[MenuType] [int] NOT NULL,
	[MenuName] [nvarchar](20) NULL,
	[RouteName] [nvarchar](100) NOT NULL,
	[RoutePath] [nvarchar](100) NOT NULL,
	[Status] [int] NULL,
	[HideInMenu] [bit] NOT NULL,
	[Sort] [int] NULL,
	[Component] [nvarchar](100) NOT NULL,
	[Icon] [nvarchar](50) NOT NULL,
	[IconType] [int] NOT NULL,
	[KeepAlive] [bit] NULL,
	[Redirect] [nvarchar](200) NULL,
	[Href] [nvarchar](200) NULL,
	[SysCreateUser] [int] NULL,
	[SysCreateTime] [datetime] NOT NULL,
	[SysUpdateUser] [int] NULL,
	[SysUpdateTime] [datetime] NOT NULL,
	[SysDeleteUser] [int] NULL,
	[SysDeleteTime] [datetime] NULL,
	[SysIsDelete] [bit] NULL,
 CONSTRAINT [PK__t_sys_me__3214EC077959FA94] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_sys_onlineuser]    Script Date: 2024/10/14 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_sys_onlineuser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ConnectionId] [varchar](200) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[UserName] [varchar](32) NOT NULL,
	[RealName] [varchar](32) NOT NULL,
	[Time] [datetime] NOT NULL,
	[Ip] [varchar](256) NOT NULL,
	[Browser] [varchar](128) NOT NULL,
	[Os] [varchar](128) NOT NULL,
 CONSTRAINT [PK_t_sys_onlineuser_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_sys_role]    Script Date: 2024/10/14 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_sys_role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SysCreateUser] [int] NULL,
	[SysCreateTime] [datetime] NULL,
	[SysUpdateUser] [int] NULL,
	[SysUpdateTime] [datetime] NULL,
	[SysDeleteUser] [int] NULL,
	[SysDeleteTime] [datetime] NULL,
	[SysIsDelete] [bit] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Desc] [nvarchar](50) NULL,
	[Status] [bit] NOT NULL,
	[DataRang] [nvarchar](20) NULL,
	[Permission] [nvarchar](200) NULL,
 CONSTRAINT [PK__t_sys_ro__3214EC07073CF5EB] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_sys_role_menu]    Script Date: 2024/10/14 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_sys_role_menu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SysCreateUser] [int] NULL,
	[SysCreateTime] [datetime] NULL,
	[SysUpdateUser] [int] NULL,
	[SysUpdateTime] [datetime] NULL,
	[SysDeleteUser] [int] NULL,
	[SysDeleteTime] [datetime] NULL,
	[SysIsDelete] [bit] NULL,
	[RoleId] [int] NOT NULL,
	[MenuId] [int] NOT NULL,
 CONSTRAINT [PK_t_sys_role_menu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_sys_role_permiss]    Script Date: 2024/10/14 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_sys_role_permiss](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SysCreateUser] [int] NULL,
	[SysCreateTime] [datetime] NULL,
	[SysUpdateUser] [int] NULL,
	[SysUpdateTime] [datetime] NULL,
	[SysDeleteUser] [int] NULL,
	[SysDeleteTime] [datetime] NULL,
	[SysIsDelete] [bit] NOT NULL,
	[RoleId] [int] NOT NULL,
	[UserPermiss] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_bs_sys_user_button_permiss] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_sys_user]    Script Date: 2024/10/14 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_sys_user](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Account] [nvarchar](20) NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[PassWord] [nvarchar](32) NOT NULL,
	[UserRolesId] [nvarchar](100) NOT NULL,
	[Status] [int] NOT NULL,
	[Avatar] [nvarchar](100) NULL,
	[Tel] [nvarchar](20) NULL,
	[Email] [nvarchar](50) NULL,
	[Remark] [nvarchar](200) NULL,
	[SysCreateUser] [int] NULL,
	[SysCreateTime] [datetime] NULL,
	[SysUpdateUser] [int] NULL,
	[SysUpdateTime] [datetime] NULL,
	[SysDeleteUser] [int] NULL,
	[SysDeleteTime] [datetime] NULL,
	[SysIsDelete] [tinyint] NULL,
	[DeptId] [int] NULL,
	[IsSuperAdmin] [bit] NULL,
 CONSTRAINT [PK__t_sys_us__3214EC0749A204F2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_sys_config] ADD  CONSTRAINT [DF_bs_webconfig_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[t_sys_menu] ADD  CONSTRAINT [DF__t_sys_men__IsHid__52593CB8]  DEFAULT ((0)) FOR [HideInMenu]
GO
ALTER TABLE [dbo].[t_sys_menu] ADD  CONSTRAINT [DF__t_sys_menu__Sort__5812160E]  DEFAULT ((0)) FOR [Sort]
GO
ALTER TABLE [dbo].[t_sys_menu] ADD  CONSTRAINT [DF__t_sys_men__IsIfr__5441852A]  DEFAULT ((0)) FOR [Icon]
GO
ALTER TABLE [dbo].[t_sys_menu] ADD  CONSTRAINT [DF__t_sys_men__IsAff__5535A963]  DEFAULT ((0)) FOR [IconType]
GO
ALTER TABLE [dbo].[t_sys_menu] ADD  CONSTRAINT [DF__t_sys_men__IsKee__534D60F1]  DEFAULT ((1)) FOR [KeepAlive]
GO
ALTER TABLE [dbo].[t_sys_menu] ADD  CONSTRAINT [DF_menu_SysCreateTime]  DEFAULT (getdate()) FOR [SysCreateTime]
GO
ALTER TABLE [dbo].[t_sys_menu] ADD  CONSTRAINT [DF_menu_SysUpdateTime]  DEFAULT (getdate()) FOR [SysUpdateTime]
GO
ALTER TABLE [dbo].[t_sys_menu] ADD  CONSTRAINT [DF__t_sys_men__SysIs__5165187F]  DEFAULT ((0)) FOR [SysIsDelete]
GO
ALTER TABLE [dbo].[t_sys_role] ADD  CONSTRAINT [DF__t_sys_rol__SysCr__778AC167]  DEFAULT (getdate()) FOR [SysCreateTime]
GO
ALTER TABLE [dbo].[t_sys_role] ADD  CONSTRAINT [DF__t_sys_rol__SysIs__787EE5A0]  DEFAULT ((0)) FOR [SysIsDelete]
GO
ALTER TABLE [dbo].[t_sys_role] ADD  CONSTRAINT [DF__t_sys_rol__Statu__797309D9]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[t_sys_role_menu] ADD  CONSTRAINT [DF_t_sys_role_menu_SysCreateTime]  DEFAULT (getdate()) FOR [SysCreateTime]
GO
ALTER TABLE [dbo].[t_sys_role_menu] ADD  CONSTRAINT [DF_t_sys_role_menu_SysIsDelete]  DEFAULT ((0)) FOR [SysIsDelete]
GO
ALTER TABLE [dbo].[t_sys_role_permiss] ADD  CONSTRAINT [DF_bs_sys_user_button_permiss_SysCreateTime]  DEFAULT (getdate()) FOR [SysCreateTime]
GO
ALTER TABLE [dbo].[t_sys_role_permiss] ADD  CONSTRAINT [DF_bs_sys_user_button_permiss_SysIsDelete]  DEFAULT ((0)) FOR [SysIsDelete]
GO
ALTER TABLE [dbo].[t_sys_user] ADD  CONSTRAINT [DF__t_sys_use__Statu__6477ECF3]  DEFAULT ('10') FOR [Status]
GO
ALTER TABLE [dbo].[t_sys_user] ADD  CONSTRAINT [DF__t_sys_use__SysCr__619B8048]  DEFAULT (getdate()) FOR [SysCreateTime]
GO
ALTER TABLE [dbo].[t_sys_user] ADD  CONSTRAINT [DF__t_sys_use__SysUp__628FA481]  DEFAULT (getdate()) FOR [SysUpdateTime]
GO
ALTER TABLE [dbo].[t_sys_user] ADD  CONSTRAINT [DF__t_sys_use__SysIs__6383C8BA]  DEFAULT ((0)) FOR [SysIsDelete]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bs_bingwallpaper', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'原本链接' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bs_bingwallpaper', @level2type=N'COLUMN',@level2name=N'MobileUrl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'原本链接' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bs_bingwallpaper', @level2type=N'COLUMN',@level2name=N'Url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bs_bingwallpaper', @level2type=N'COLUMN',@level2name=N'CreatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bs_bingwallpaper', @level2type=N'COLUMN',@level2name=N'UpdatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bs_bingwallpaper', @level2type=N'COLUMN',@level2name=N'CreatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bs_bingwallpaper', @level2type=N'COLUMN',@level2name=N'CreatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bs_bingwallpaper', @level2type=N'COLUMN',@level2name=N'UpdatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bs_bingwallpaper', @level2type=N'COLUMN',@level2name=N'UpdatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'软删除标记' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bs_bingwallpaper', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'配置类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_config', @level2type=N'COLUMN',@level2name=N'ConfigType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父级菜单ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_menu', @level2type=N'COLUMN',@level2name=N'ParentId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'菜单类型1 .目录 2.菜单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_menu', @level2type=N'COLUMN',@level2name=N'MenuType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'菜单名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_menu', @level2type=N'COLUMN',@level2name=N'MenuName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'路由名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_menu', @level2type=N'COLUMN',@level2name=N'RouteName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'路由路径' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_menu', @level2type=N'COLUMN',@level2name=N'RoutePath'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'菜单状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_menu', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'隐藏菜单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_menu', @level2type=N'COLUMN',@level2name=N'HideInMenu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_menu', @level2type=N'COLUMN',@level2name=N'Sort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页面组件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_menu', @level2type=N'COLUMN',@level2name=N'Component'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图标' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_menu', @level2type=N'COLUMN',@level2name=N'Icon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图标类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_menu', @level2type=N'COLUMN',@level2name=N'IconType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'连接Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_onlineuser', @level2type=N'COLUMN',@level2name=N'ConnectionId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_onlineuser', @level2type=N'COLUMN',@level2name=N'UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'账号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_onlineuser', @level2type=N'COLUMN',@level2name=N'UserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'真实姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_onlineuser', @level2type=N'COLUMN',@level2name=N'RealName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'连接时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_onlineuser', @level2type=N'COLUMN',@level2name=N'Time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'连接IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_onlineuser', @level2type=N'COLUMN',@level2name=N'Ip'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'浏览器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_onlineuser', @level2type=N'COLUMN',@level2name=N'Browser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作系统' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_onlineuser', @level2type=N'COLUMN',@level2name=N'Os'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_role_menu', @level2type=N'COLUMN',@level2name=N'RoleId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_role_permiss', @level2type=N'COLUMN',@level2name=N'RoleId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户访问接口的权限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_sys_role_permiss', @level2type=N'COLUMN',@level2name=N'UserPermiss'
GO
USE [master]
GO
ALTER DATABASE [MalusAdminTest] SET  READ_WRITE 
GO
