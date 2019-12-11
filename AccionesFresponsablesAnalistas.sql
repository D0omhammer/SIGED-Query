- script Funcionarios Responsables tr�mites recibidos  del 03-10-2018

select t.numeracion, b.* from sgd.bitacora b
inner join sgd.tramite t
ON t.id = b.idtramite 
where 
b.areadestino in (select nombre from sgd.area where idareapadre = 12 or id = 12)
and b.roldestino = 'Funcionario Responsable'
and cast(b.fecha AS date) = cast('2018-07-23' AS date)


- script Autoridad tr�mites recibidos  del 03-10-2018

select t.numeracion, b.* from sgd.bitacora b
inner join sgd.tramite t
ON t.id = b.idtramite 
where 
b.areadestino in (select nombre from sgd.area where idareapadre = 12 or id = 12)
and b.roldestino = 'Autoridad'
and cast(b.fecha AS date) = cast('2018-07-23' AS date)


--Script Funcionarios Responsables  tr�mites recibidos desde el 19-07-2018 hasta hoy

select t.numeracion, b.* from sgd.bitacora b
inner join sgd.tramite t
ON t.id = b.idtramite 
where 
b.areadestino in (select nombre from sgd.area where idareapadre = 12 or id = 12)
and b.roldestino = 'Funcionario Responsable'
and cast(b.fecha AS date) >= cast('2018-07-19' AS date)

--script Analistas tr�mites recibidos del 12-02-2018

select t.numeracion, b.* from sgd.bitacora b
inner join sgd.tramite t
ON t.id = b.idtramite 
where 
b.areadestino in (select nombre from sgd.area where idareapadre = 12 or id = 12)
and b.roldestino = 'Analista'
and cast(b.fecha AS date) = cast('2019-02-12' AS date)


--Script Analistas tr�mites recibidos desde el 19-07-2018 hasta hoy

select t.numeracion, b.* from sgd.bitacora b
inner join sgd.tramite t
ON t.id = b.idtramite 
where 
b.areadestino in (select nombre from sgd.area where idareapadre = 12 or id = 12)
and b.roldestino = 'Analista'
and cast(b.fecha AS date) >= cast('2018-07-19' AS date)