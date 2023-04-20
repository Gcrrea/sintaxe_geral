/****** Script do comando SelectTopNRows de SSMS  ******/
SELECT MAX(totalvenda) as total,statusid
  FROM BI.dbo.pedidos_valores
  GROUP BY statusid

  /****** Por padrão o SQL pega o valor NULL e ignora, nao considera Porem existem situações em que precisa usar eles,
  para contar como um valor 0 por exemplo, nesse caso é preciso usar uma função chamada ISNULL, a função COUNT(*)
  é a unica que nao ignora o null ele é uma função de contagem, com exceção do COUNT sem o (*) ******/

  select ISNULL(totalvenda,0) totalvenda from BI.dbo.pedidos_valores


 SELECT unidadeid, 
	AVG(ISNULL(totalvenda,0)) totalvenda 
	from BI.dbo.pedidos_valores
 GROUP BY unidadeid


  SELECT 
	DISTINCT 
		valores.unidadeid,
		  (SELECT COUNT(*) FROM BI.dbo.pedidos_valores as v
		  WHERE v.unidadeid = valores.unidadeid
		  GROUP BY v.unidadeid) contagempedidos
  FROM BI.dbo.pedidos_valores as valores
  
  
  
 SELECT * FROM BI.dbo.pedidos_valores


/****** faz um ranking ex 1-,2 e 3 lugar  ******/
WITH teste_rank  
	AS (
		SELECT
			  p.cod_pedido
			  ,p.referencia
			  ,p.quantidade
			  ,p.valor
			  ,RANK() OVER (PARTITION BY p.referencia ORDER BY p.valor DESC) AS rankvalor
			  ,desconto
	  FROM BIGDATA.loja.Pedidos_TESTE AS p) 

select * from teste_rank 


select * from BIGDATA.loja.Pedidos_TESTE 

WHERE rankvalor = 1


/****** faz um ranking porem nao aceita gaps ou seja, se ambos tiver valor igual, ambos vao ser 1, 2 ou 3  ******/
WITH teste_dese_rank
	AS (
		SELECT p.cod_pedido
			  ,p.referencia
			  ,p.quantidade
			  ,p.valor
			  ,DENSE_RANK() OVER (PARTITION BY p.referencia ORDER BY p.valor DESC) AS dense_rankvalor
			  ,desconto
	  FROM BIGDATA.loja.Pedidos_TESTE AS p) 

select * from teste_dese_rank


/****** cria grupos porem nao ordena exemplo, se um item da coluna referencia  ex item 123 aparecer 5 vezes, ele faz a contagem das linhas, 
depois se aparecer outro item ex 456 aparecer 3 vezes ele faz a contagem da linha ou seja 
123 = 1, 123=2,123=3,123=4,123=5,456=1,456=2,456=3
******/
WITH teste_row_number
	AS (
		SELECT p.cod_pedido
			  ,p.referencia
			  ,p.quantidade
			  ,p.valor
			  ,ROW_NUMBER() OVER (PARTITION BY p.referencia ORDER BY p.valor DESC) AS row_numer
			  ,desconto
	  FROM BIGDATA.loja.Pedidos_TESTE AS p) 

select * from teste_row_number


/****** cria grupos de acordo com um criterio que passamos, ex pedi 3 grupos 'notem' que passei a quantidade que
quero de grupos dentro do NTILE 'NTILE(3) OVER (PARTITION BY ref_p.statuspedido' e informei a coluna que tem eles no 
PARTITION BY   e estou passando o valor no order by DESC, ou seja ele vai fazer 3 grupos ordenando pelo maior valor******/
WITH teste_ntile
	AS (
		SELECT p.cod_pedido
			  ,p.referencia
			  ,p.quantidade
			  ,p.valor
			  ,ref_p.statuspedido
			  ,NTILE(3) OVER (PARTITION BY ref_p.statuspedido ORDER BY p.valor DESC) AS row_ntile
			  ,p.desconto
	  FROM BIGDATA.loja.Pedidos_TESTE AS p
	  LEFT JOIN BIGDATA.loja.Pedidos AS ref_p ON ref_p.referencia = p.referencia)

	SELECT * FROM teste_ntile
	


/****** PIVOT ******/

with testes as (
	select 
	x.totalVenda
	,x.unidadeId 
	,x.unidadeId as loja
	,x.lojanome
	,x.uf
	,(SELECT COUNT(*) FROM BI.dbo.pedidos_valores as v
	where v.unidadeId = x.unidadeId
	group by v.unidadeId) tot
	from BI.dbo.fato_venda as x
	)
	select *
	from testes
	 pivot
	 (
		SUM(totalVenda)
		FOR lojanome IN ("Pelotas","Indaiatuba")
	 )a
order by a.unidadeId	



SELECT totalvenda
,totalcusto

,DATEPART(yyyy,datacadastro) as ano 

FROM dbo.pedidos_valores


SELECT 
	lojanome
	,DATEPART(yyyy,datacadastro) as ano 
    ,sum(totalVenda) venda
  FROM BI.dbo.fato_venda
  GROUP BY ROLLUP(lojanome,dataCadastro)


SELECT
    
	lojanome
	,dataCadastro
    ,sum(totalVenda) venda

  FROM BI.dbo.fato_venda
  GROUP BY CUBE(lojanome,dataCadastro)



select COUNT(*) 
FROM
(SELECT uf FROM 
	dbo.fato_venda)X