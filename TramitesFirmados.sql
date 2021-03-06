declare @idUsuarioArea bigint;
-------------------------------------------------------------------------------------------------------
set @idUsuarioArea=5466;
------------------------------------------------------------------------------------------------------
declare @tramites table(
numeroTramite varchar(100),
fechaTramite datetime2(7),
tipoTramite varchar(5),
asuntoTramite varchar(900),
numeroDocumento varchar(100),
tipoDocumento varchar(100),
fechaDocumento datetime2(7),
asuntoDocumento varchar(900)
);
	declare @nombreDestinatario varchar(200);
	declare @tipoTramite varchar(5);
	declare @tipoDocumento varchar(100);
	declare @fechaTramite datetime2(7);
	declare @fechaDocumento datetime2(7);
	declare @numeroTramite varchar(100);
	declare @idDocumento bigint;
	declare @numeroDocumento varchar(100);
	declare @asuntoTramite varchar(900);
	declare @asuntoDocumento varchar(900);
	declare @idUsuarioAreaDE bigint;
	declare @idUsuarioAreaPARA bigint;
	declare docs_firmados cursor for
		select d.id,t.numeracion as numeroTramite, d.numeracion as numeroDocumento, t.asunto as asuntoTramite, d.asunto as asuntoDocumento,
		t.fechaDefinitiva as fechaTramite, d.fechaDefinitiva  as fechaDocumento, d.idUsuarioAreaElaboradoPor as ID, td.nombre as tipoDocumeno
	from sgd.DetalleDocumento as  dd  inner join sgd.Documento as d on d.id=dd.idDocumento  and d.estado='ACT' and d.etapa='DFD'
	inner join sgd.Tramite as t on t.id=d.idTramite inner join sgd.TipoDocumento td on td.id=d.idTipoDocumento
	where dd.estado='ACT' and dd.tipo =1003 and dd.[idParticipante] = @idUsuarioArea and t.estado='ACT'

	open docs_firmados
		fetch next from docs_firmados into @idDocumento,@numeroTramite,@numeroDocumento,@asuntoTramite,@asuntoDocumento,@fechaTramite,@fechaDocumento,@tipoTramite,@tipoDocumento
		WHILE @@FETCH_STATUS = 0
			BEGIN

				insert into @tramites (numeroTramite,numeroDocumento,tipoTramite,tipoDocumento,fechaTramite,asuntoTramite,fechaDocumento,asuntoDocumento)
				values (@numeroTramite,@numeroDocumento,@tipoTramite,@tipoDocumento,@fechaTramite,@asuntoTramite,@fechaDocumento, @asuntoDocumento)
				--print @numeroTramite

			fetch next from docs_firmados into @idDocumento,@numeroTramite,@numeroDocumento,@asuntoTramite,@asuntoDocumento,@fechaTramite,@fechaDocumento,@tipoTramite,@tipoDocumento
			END
			select * from @tramites order by fechaDocumento;
	CLOSE docs_firmados
	DEALLOCATE  docs_firmados
