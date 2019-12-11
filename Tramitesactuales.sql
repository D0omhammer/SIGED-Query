use [GESTION_DOCUMENTAL]
go
declare @idArea bigint;
set @idArea=12;
-----------------------------------------------------------------------USUARIOS-------------------------------------------------------------------------------------------
select t.numeracion as 'N�mero de tr�mite', a.nombre as '�rea del funcionario destino', AO.nombre as '�rea del funcionario origen',
u.nombre as 'Nombre del funcionario destino',u.nombre as 'Nombre del funcionario origen', t.fechaRegistro as 'Fecha de creaci�n del tr�mite',
m.fechaAsignacion as 'Fecha de asignaci�n del tr�mite al funcionario', t.estado as 'Estado del tr�mite', acc.nombre as 'Acci�n por la que est� en la bandeja de recibidos',
m.comentario as 'Comentario', pO.nombre as 'Rol funcionario origen', t.asunto as 'asunto'
 from sgd.Movimiento m
inner join sgd.Accion acc on acc.id=m.idAccionOrigen
--Tramite
inner join sgd.Tramite t on t.id=m.idTramite
--Destino
inner join sgd.UsuarioAreaPerfil uap on uap.id=m.idDestino and uap.estado='ACT'
inner join sgd.Perfil p on p.id=uap.idPerfil
inner join sgd.UsuarioArea ua on ua.id=uap.idUsuarioArea and ua.estado='ACT'
inner join sgd.Usuario u on u.id=ua.idUsuario
inner join sgd.Area a on a.id=ua.idArea and a.estado='ACT' and (a.id in (select id from sgd.area where idAreaPadre=@idArea)or a.id=@idArea)
--Origen
inner join sgd.UsuarioAreaPerfil uapO on uapO.id=m.idOrigen
inner join sgd.Perfil pO on pO.id=uapO.idPerfil
inner join sgd.UsuarioArea uaO on uaO.id=uapO.idUsuarioArea
inner join sgd.Usuario uO on uO.id=uaO.idUsuario
inner join sgd.area aO on aO.id=uaO.idArea
where m.tipoBandeja='REC' and m.estado='ACT' and m.tipoDestino='USR' and m.idDestino!=m.idOrigen

union
-----------------------------------------------------------------------GRUPOS-------------------------------------------------------------------------------------------
select t.numeracion,ad.nombre,aO.nombre,'',uO.nombre,t.fechaRegistro,m.fechaAsignacion,t.estado, acc.nombre,m.comentario,pO.nombre, ''
from sgd.Movimiento m
inner join sgd.Accion acc on m.idAccionOrigen =acc.id
inner join sgd.Tramite t on m.idTramite=t.id
inner join sgd.AreaPerfil ap on ap.id=m.idDestino and (ap.idArea in (select id from sgd.area where idAreaPadre=@idArea)or ap.idarea=@idArea)
inner join sgd.Area ad on ad.id=ap.idArea
inner join sgd.Perfil pa on pa.id=ap.idPerfil

--origen
inner join sgd.UsuarioAreaPerfil uapO on uapO.id=m.idOrigen
inner join sgd.Perfil pO on pO.id=uapO.idPerfil
inner join sgd.UsuarioArea uaO on uaO.id=uapO.idUsuarioArea
inner join sgd.Area aO on aO.id=uaO.idArea
inner join sgd.Usuario uO on uO.id=uaO.idUsuario
 where m.tipoBandeja='REC' and m.estado='ACT' and m.tipoDestino='GRP';
