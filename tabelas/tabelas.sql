CREATE TABLE [loja].[Pedidos](
	[cod_pedido] [int] IDENTITY(1,1) NOT NULL,
	[referencia] [varchar](200) NULL,
	[quantidade] [int] NULL,
	[cod_produto] [int] NULL,
	[valor] [float] NULL,
	[desconto] [float] NULL,
	[margem] [float] NULL,
	[cod_endereco] [int] NULL,
	[cod_cliente] [int] NULL,
	[data_atualizacao] [datetime] NULL,
	[datacriacao] [datetime] NULL,
	[statuspedido] [varchar](200) NULL,
 CONSTRAINT [PK_Pedidos] PRIMARY KEY CLUSTERED 
(
	[cod_pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [loja].[Pedidos] ADD  DEFAULT (getdate()) FOR [data_atualizacao]
GO



CREATE TABLE [loja].[Produtos](
	[cod_produto] [int] IDENTITY(1,1) NOT NULL,
	[sku] [varchar](1000) NULL,
	[nome_produto] [varchar](1000) NULL,
	[quantidade] [int] NULL,
	[custo] [float] NULL,
	[valor] [float] NULL,
	[desconto] [float] NULL,
	[venda] [float] NULL,
	[data_atualizacao] [datetime] NULL,
	[marca] [varchar](100) NULL,
	[imagem] [varchar](max) NULL,
	[atributos] [varchar](max) NULL,
	[orders] [int] NULL,
	[estoque] [int] NULL,
	[descricao] [varchar](max) NULL,
 CONSTRAINT [PK_Produtos] PRIMARY KEY CLUSTERED 
(
	[cod_produto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [loja].[Produtos] ADD  DEFAULT (getdate()) FOR [data_atualizacao]
GO




CREATE TABLE [loja].[usuarios](
	[cod_usuario] [int] IDENTITY(1,1) NOT NULL,
	[cod_endereco] [varchar](200) NULL,
	[email] [varchar](200) NULL,
	[password] [varchar](200) NULL,
	[datalogado] [varchar](200) NULL,
	[data_cadastro] [varchar](200) NULL,
	[status] [varchar](200) NULL,
	[data_atualizado] [datetime] NULL,
	[nomeusuario] [varchar](200) NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[cod_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO