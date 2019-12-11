use [GESTION_DOCUMENTAL]
go
select b.areaOrigen,t.numeracion,t.fechaRegistro,t.estado,t.asunto,t.tipo,t.reservado,t.urgente,t.lotaip,t.fechaVencimiento,accion, destino from sgd.Bitacora b
inner join sgd.Tramite t on t.id=b.idTramite
 where
 areaOrigen like '%Direcci�n General%'
and  CONVERT(date, b.fecha)>= CONVERT(varchar, '2019/06/01', 103)
and  CONVERT(date, b.fecha)<= CONVERT(varchar, '2019/09/30', 103);
