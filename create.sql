CREATE TABLE public.ale
(
    clave numeric NOT NULL,
    tipo varchar(15) NOT NULL,
    CONSTRAINT pk_clave_ale PRIMARY KEY (clave)
);

CREATE TABLE public.lager
(
     clave numeric NOT NULL,
     tipo varchar(15) NOT NULL,
     CONSTRAINT pk_clave_lager PRIMARY KEY (clave)
);

CREATE TABLE public.ingrediente
(
     id numeric NOT NULL,
     nombre varchar(15) NOT NULL,
     tipo varchar(15) NOT NULL,
     CONSTRAINT pk_id_ingrediente PRIMARY KEY (id)
);

CREATE TABLE public.cerveza_artesanal
(
     clave numeric NOT NULL,
     nombre varchar(15) NOT NULL,
     descripcion varchar(50) NOT NULL, 
     precio_unitario numeric NOT NULL,
     fk_ale numeric,
     fk_lager numeric,
     CONSTRAINT pk_clave_cerveza PRIMARY KEY (clave),
     CONSTRAINT fk_ale_cerveza FOREIGN KEY (fk_ale) REFERENCES ale(clave),
     CONSTRAINT fk_lager_cerveza FOREIGN KEY (fk_lager) REFERENCES lager(clave),
);

CREATE TABLE public.historia_cerveza  //NO ESTA EN EL ER
     clave numeric NOT NULL,
     descripcion varchar NOT NULL,
     fk_cerveza_artesanal numeric NOT NULL,
     CONSTRAINT pk_clave_historia_cerveza PRIMARY KEY (clave),
     CONSTRAINT fk_fk_cerveza_artesanal_historia_cerveza FOREIGN KEY (fk_cerveza_artesanal) REFERENCES cerveza_artesanal(clave)
);

CREATE TABLE public.receta 
(
     clave numeric NOT NULL,
     descripcion varchar(50) NOT NULL,
     fk_cerveza numeric NOT NULL,
     CONSTRAINT pk_clave_receta PRIMARY KEY (clave),
     CONSTRAINT fk_fk_cerveza FOREIGN KEY (fk_cerveza) REFERENCES cerveza_artesanal(clave)
);

CREATE TABLE public.receta_ingre
(
     clave numeric NOT NULL,
     fk_ingrediente numeric NOT NULL,
     fk_receta numeric NOT NULL,
     cant_ingrediente numeric NOT NULL,
     CONSTRAINT pk_receta_ingrediente PRIMARY KEY (clave),
     CONSTRAINT fk_fk_ingrediente FOREIGN KEY (fk_ingrediente) REFERENCES ingrediente(id),
     CONSTRAINT fk_fk_receta FOREIGN KEY (fk_receta) REFERENCES receta (clave)
);   

CREATE TABLE public.caracteristica      //Que es descripcion, y no deberia ser opcional en todo caso?
(
     clave numeric NOT NULL,
     tipo varchar(15) NOT NULL,
     valor varchar(15) NOT NULL,
     descripcion varchar(50) NOT NULL,
     CONSTRAINT pk_clave_caracteristica PRIMARY KEY (clave)
);

CREATE TABLE public.cerveza_caracteristica  //No se colocan clave compuestas, se coloca un id en la tabla y solo se usan las fk
(
     id numeric NOT NULL,
     fk_cerveza numeric NOT NULL,
     fk_caracteristica numeric NOT NULL,
     CONSTRAINT pk_id_cerveza_caracteristica PRIMARY KEY (id),
     CONSTRAINT fk_fk_cerveza_cerveza_caracteristica FOREIGN KEY (fk_cerveza) REFERENCES cerveza_artesanal(clave),
     CONSTRAINT fk_fk_caracteristica_cerveza_caracteristica FOREIGN KEY (fk_caracteristica) REFERENCES caracteristica(clave)
);

CREATE TABLE public.departamento
(
     clave numeric NOT NULL,  
     nombre varchar(20) NOT NULL,
     CONSTRAINT pk_clave_departamento PRIMARY KEY (clave)
);

CREATE TABLE public.direccion
(
     clave numeric NOT NULL,
     tipo varchar(10) NOT NULL,
     nombre varchar(1) NOT NULL,
     fk_direccion numeric,
     CONSTRAINT pk_clave_direccion PRIMARY KEY (clave),
     CONSTRAINT  fk_fk_direccion FOREIGN KEY (fk_direccion) REFERENCES lugar(clave),
     CONSTRAINT chk_tipo_direccion CHECK (tipo in ('Continente','Pais','Estado','Municipio','Parroquia') ) 
);

CREATE TABLE public.privilegio //NO ESTA EN EL ER
(
     clave numeric NOT NULL,
     tipo varchar NOT NULL,
     tabla varchar NOT NULL,
     CONSTRAINT pk_clave_privilegio PRIMARY KEY (clave)
);

CREATE TABLE public.rol   //Por que le quitamos tipo al rol?
(
     clave numeric NOT NULL,
     nombre varchar(13) NOT NULL,
     CONSTRAINT pk_clave_rol PRIMARY KEY (clave)
);

CREATE TABLE public.rol_privilegio
(
     clave numeric NOT NULL,
     fk_rol numeric NOT NULL,
     fk_privilegio numeric NOT NULL,
     CONSTRAINT pk_clave_rol_privilegio PRIMARY KEY (clave),
     CONSTRAINT fk_fk_rol_rol_privilegio FOREIGN KEY (fk_rol) REFERENCES rol(clave),
     CONSTRAINT fk_fk_privilegio_rol_privilegio FOREIGN KEY (fk_privilegio) REFERENCES privilegio(clave)
);

CREATE TABLE public.personal
(
     clave numeric NOT NULL,  
     nombre varchar(15) NOT NULL,
     apellido varchar(15) NOT NULL,
     ci numeric(9) NOT NULL,
     salario varchar(11) NOT NULL, 
     cargo varchar(11( NOT NULL,
     fk_rol numeric,
     CONSTRAINT pk_clave_personal PRIMARY KEY (clave),
     CONSTRAINT fk_fk_rol_personal FOREIGN KEY (fk_rol) REFERENCES rol(clave)
);

CREATE TABLE public.horario 
(
     clave numeric NOT NULL,
     dia varchar NOT NULL,
     hora_inicio date NOT NULL,
     hora_fin date NOT NULL,
     CONSTRAINT pk_clave_horario PRIMARY KEY (clave),
);

CREATE TABLE public.beneficio
(
     clave numeric NOT NULL,
     valor numeric NOT NULL,
     tipo varchar NOT NULL,
     CONSTRAINT pk_clave_beneficio PRIMARY KEY (clave)
);

CREATE TABLE public.personal_beneficio
(
     clave numeric NOT NULL,
     fk_beneficio numeric NOT NULL,
     fk_personal numeric NOT NULL,
     CONSTRAINT pk_clave_personal_beneficio PRIMARY KEY (clave),
     CONSTRAINT fk_fk_personal_personal_beneficio FOREIGN KEY (fk_personal) REFERENCES personal(clave),
     CONSTRAINT fk_fk_beneficio_personal_beneficio FOREIGN KEY (fk_beneficio) REFERENCES beneficio(clave)
);

CREATE TABLE public.personal_horario 
(
     clave numeric NOT NULL,
     tipo varchar NOT NULL,
     fk_personal numeric NOT NULL,
     fk_horario numeric NOT NULL,
     CONSTRAINT pk_clave_personal_horario PRIMARY KEY (clave),
     CONSTRAINT fk_fk_personal_personal_horario FOREIGN KEY (fk_personal) REFERENCES personal(clave),
     CONSTRAINT fk_fk_horario_personal_horario FOREIGN KEY (fk_horario) REFERENCES horario(clave),
     CONSTRAINT chk_tipo_horario_personal CHECK (tipo in('Asistente','Inasistente'))
);

CREATE TABLE public.proveedor
(
     rif numeric NOT NULL,
     razon_social varchar NOT NULL,
     denominacion_comercial varchar NOT NULL,
     pagina_web varchar NOT NULL,
     fecha_afiliacion date NOT NULL,
     fk_direccion numeric NOT NULL,
     CONSTRAINT pk_rif_proveedor PRIMARY KEY (rif)
     CONSTRAINT fk_fk_direccion_proveedor FOREIGN KEY (fk_direccion) REFERENCES direccion(clave)
);

CREATE TABLE public.cerveza_proveedor  //Una venta no podria tener una o mas cervezas?
(
     clave numeric NOT NULL,
     fk_cerveza_artesanal numeric NOT NULL,
     fk_proveedor numeric NOT NULL,
     CONSTRAINT pk_clave_cerveza_proveedor PRIMARY KEY (clave),
     CONSTRAINT fk_fk_cerveza_cerveza_proveedor FOREIGN KEY (fk_cerveza_artesanal REFERENCES cerveza_artesanal(clave),
     CONSTRAINT fk_fk_proveedor_cerveza_proveedor FOREIGN KEY (fk_proveedor) REFERENCES proveedor(rif)
);

CREATE TABLE public.evento    //Agregue la fecha del evento, ya que no tenia ni tiene en el ER
(
     clave numeric NOT NULL,
     fecha_inicio date NOT NULL,
     fecha_fin date NOT NULL,
     nombre varchar NOT NULL,
     aforo numeric,
     fk_direccion numeric NOT NULL,
     CONSTRAINT pk_clave_evento PRIMARY KEY (clave),
     CONSTRAINT fk_fk_direccion_evento FOREIGN KEY (fk_direccion) REFERENCES direccion(clave)
);

CREATE TABLE public.evento_proveedor
(
     clave numeric NOT NULL,
     fk_evento numeric NOT NULL,
     fk_proveedor numeric NOT NULL,
     CONSTRAINT pk_clave_evento_proveedor PRIMARY KEY (clave),
     CONSTRAINT fk_fk_evento_evento_proveedor FOREIGN KEY (fk_evento) REFERENCES evento(clave),
     CONSTRAINT fk_fk_proveedor_eventoproveedor FOREIGN KEY (fk_proveedor) REFERENCES proveedor(rif)
);

CREATE TABLE public.pasillo
(
     clave numeric NOT NULL,
     numero numeric NOT NULL,
     CONSTRAINT pk_pasillo PRIMARY KEY (clave)
);

CREATE TABLE public.tienda
(
     clave numeric NOT NULL,
     tipo varchar(7) NOT NULL,
     fisica_nombre varchar,
     fk_fisica_direccion numeric NOT NULL,
     virtual_pagina_web varchar,
     CONSTRAINT pk_tienda PRIMARY KEY (clave),
     CONSTRAINT fk_fk_fisica_direccion_tienda FOREIGN KEY (fisica_direccion) REFERENCES direccion(clave)
)

CREATE TABLE public.zona   //Revisar Cardinalidad entre pasillo y zona, relacion con rol?
(
     clave numeric NOT NULL,
     numero_estante numeric NOT NULL,
     numero_repisa numeric NOT NULL,
     fk_tienda numeric NOT NULL,
     fk_rol numeric NOT NULL,
     fk_pasillo numeric NOT NULL,
     CONSTRAINT pk_zona PRIMARY KEY (clave),
     CONSTRAINT fk_fk_tienda_zona FOREIGN KEY (fk_tienda) REFERENCES tienda(clave),
     CONSTRAINT fk_fk_rol_zona FOREIGN KEY (fk_rol) REFERENCES rol(clave),
     CONSTRAINT fk_fk_pasillo_zona FOREIGN KEY (fk_pasillo) REFERENCES pasillo(clave)
);

CREATE TABLE public.venta         //Podriamos evitarnos el atributo codigo y usar como pk el atributo nro_factura
(                                 // Hay que revisar la relacion de esta entidad con historico_venta, ya que un detalle solo vendria de un historico
     codigo numeric NOT NULL,
     total numeric NOT NULL,
     nro_factura numeric NOT NULL,
     fecha date NOT NULL,
     CONSTRAINT pk_codigo_venta PRIMARY KEY (codigo)
);

CREATE TABLE public.detalle_venta     // A su vez, un historico inventario no tendria un solo inventario? La relacion no deberia ser uno a uno?
(
     codigo numeric NOT NULL,
     cantidad numeric NOT NULL,
     precio_unitario numeric NOT NULL,
     fk_venta numeric NOT NULL,
     fk_cerveza_proveedor numeric NOT NULL,
     CONSTRAINT pk_codigo_detalle_venta PRIMARY KEY (codigo),
     CONSTRAINT fk_fk_venta_detalle_venta FOREIGN KEY (fk_venta) REFERENCES venta(codigo),
     CONSTRAINT fk_fk_cerveza_proveedor_detalle_venta FOREIGN KEY (fk_cerveza_proveedor) REFERENCES cerveza_proveedor(clave)
);

CREATE TABLE public.status_venta   //Falta en el ER
(
     clave numeric NOT NULL,
     fk_status numeric NOT NULL,
     fk_venta numeric NOT NULL,
     CONSTRAINT pk_status_venta PRIMARY KEY (clave),
     CONSTRAINT fk_fk_status_status_venta FOREIGN KEY (fk_status) REFERENCES status(clave),
     CONSTRAINT fk_fk_venta_status_venta FOREIGN KEY (fk_venta) REFERENCES venta(codigo)
);

CREATE TABLE public.cliente 
(
     rif(13) numeric NOT NULL,
     tipo varchar(8) NOT NULL,
     fk_direccion_fisica numeric NOT NULL,
     natural_ci numeric(9),
     natural_nombre varchar(15),
     natural_apellido varchar(15),
     juridico_denominacion_comercial varchar(20),
     juridico_razon_social varchar(20),
     juridico_pagina_web varchar(20),
     juridico_capital numeric,
     juridico_fk_direccion_fiscal numeric NOT NULL,
     CONSTRAINT pk_cliente PRIMARY KEY (rif)
     CONSTRAINT chk_tipo_cliente CHECK (tipo in ('Natural','Juridico')),
     CONSTRAINT fk_fk_direccion_fisica_cliente FOREIGN KEY (fk_direccion_fisica) REFERENCES direccion(clave),
     CONSTRAINT fk_juridico_fk_direccion_fiscal_cliente FOREIGN KEY (juridico_fk_direccion_fiscal) REFERENCES direccion(clave)
);

CREATE TABLE public.comentario_cerveza
(
     clave numeric NOT NULL,
     calificacion numeric(1,1) NOT NULL,
     descripcion varchar(100),
     fk_cliente numeric NOT NULL,
     fk_cerveza numeric NOT NULL,
     CONSTRAINT pk_comentario_cerveza PRIMARY KEY (clave),
     CONSTRAINT fk_fk_cliente_comentario_cerveza FOREIGN KEY (fk_cliente) REFERENCES cliente(rif),
     CONSTRAINT fk_fk_cerveza_comentario_cerveza FOREIGN KEY (fk_cerveza) REFERENCES cerveza_artesanal(clave)
);

CREATE TABLE public.correo_electronico     //No se que es tipo, por lo tanto no se coloco
(
     clave numeric NOT NULL,
     nombre numeric NOT NULL,
     fk_cliente numeric NOT NULL,
     CONSTRAINT pk_clave_correo_electronico PRIMARY KEY (clave),
     CONSTRAINT fk_fk_cliente_correo_electronico FOREIGN KEY (fk_cliente) REFERENCES cliente(rif)
);

CREATE TABLE public.compra //no coloque el atributo tipo ya que no se que significa, adicionalmente, el arco exclusivo es necesario? No se puede colocar solo una relacion con Tienda y ya?
(                          //en caso de que se vaya a dejar con el arco, la cardinalidad del lado de compra esta mal, deberia ser doble opcional, porque la compra no puede ser fisica y virtual, entonces seria opcional por todos lados, no?
     clave numeric NOT NULL,
     total_pago numeric NOT NULL,
     nro_factura numeric NOT NULL,
     fecha_compra date NOT NULL,
     fk_tienda_fisica numeric,
     fk_tienda_virtual numeric,
     fk_cliente numeric NOT NULL,
     CONSTRAINT pk_clave_status PRIMARY KEY (clave),
     CONSTRAINT fk_fk_tienda_fisica_compra FOREIGN KEY (fk_tienda_fisica) REFERENCES tienda(clave),
     CONSTRAINT fk_fk_tienda_virtual_compra FOREIGN KEY (fk_tienda_virtual) REFERENCES tienda(clave),
     CONSTRAINT fk_fk_cliente_compra FOREIGN KEY (fk_cliente) REFERENCES cliente(rif)
);

CREATE TABLE public.detalle_compra //Falta el fk_rol?
(
     clave numeric NOT NULL,
     cantidad numeric NOT NULL,
     fk_compra numeric NOT NULL,
     fk_cerveza numeric NOT NULL,
     CONSTRAINT pk_clave_detalle_compra PRIMARY KEY (clave),
     CONSTRAINT fk_fk_compra_detalle_compra FOREIGN KEY (fk_compra) REFERENCES compra(clave),
     CONSTRAINT fk_fk_cerveza_detalle_compra FOREIGN KEY (fk_cerveza) REFERENCES cerveza_artesanal(clave)
);

CREATE TABLE public.historico_inventario_cerveza   //Fecha final es para ?  REVISAR la cardinalidad entre inventario e historico inventario - RELACION CON TIENDA (?)
(
     clave numeric NOT NULL,
     cant_disponible numeric NOT NULL,
     fecha_inicio date NOT NULL,
     fecha_fin date,
     fk_cerveza numeric NOT NULL,
     fk_detalle_venta numeric,
     fk_detalle_compra numeric,
     fk_inventario numeric NOT NULL,
     CONSTRAINT pk_clave_historico_inventario_cerveza PRIMARY KEY (clave),
     CONSTRAINT fk_fk_cerveza FOREIGN KEY (fk_cerveza) REFERENCES cerveza_artesanal(clave),
     CONSTRAINT fk_fk_detalle_compra_historico_inventario FOREIGN KEY (fk_detalle_compra) REFERENCES detalle_compra(clave),
     CONSTRAINT fk_fk_detalle_venta_historico_inventario FOREIGN KEY(fk_detalle_venta) REFERENCES detalle_venta(codigo),
     CONSTRAINT fk_fk_inventario_historico_inventario FOREIGN KEY (fk_inventario) REFERENCES inventario(clave)
);

CREATE TABLE public.historico_puntos_cliente  //Falta el chck en tipo
(
     clave numeric NOT NULL,
     cantidad numeric NOT NULL,
     fecha_cambio date NOT NULL,
     tipo char NOT NULL,
     fk_cliente numeric NOT NULL,
     CONSTRAINT pk_clave_historico_puntos_cliente PRIMARY KEY (clave),
     CONSTRAINT fk_fk_cliente_historico_puntos_cliente FOREIGN KEY (fk_cliente) REFERENCES cliente(rif),
     CONSTRAINT chk_tipo_historico_puntos_cliente CHECK (tipo in('+','-'))
);

CREATE TABLE public.persona_contacto
(
     clave numeric NOT NULL,
     nombre numeric NOT NULL,
     numero numeric NOT NULL,
     fk_cliente numeric NOT NULL,
     CONSTRAINT pk_clave_persona_contacto PRIMARY KEY (clave),
     CONSTRAINT fk_fk_cliente_persona_contacto FOREIGN KEY (fk_cliente) REFERENCES cliente(rif)
);

CREATE TABLE public.telefono
(
     clave numeric NOT NULL,
     numero numeric NOT NULL,
     fk_cliente numeric,
     fk_proveedor numeric,
     CONSTRAINT pk_clave_telefono PRIMARY KEY (clave),
     CONSTRAINT fk_fk_cliente_telefono FOREIGN KEY (fk_cliente) REFERENCES cliente(rif),
     CONSTRAINT fk_fk_proveedor_cliente FOREIGN KEY (fk_proveedor) REFERENCES proveedor(rif)
);

CREATE TABLE public.inventario     //Una zona no deberia tener un solo inventario? No se guarda historico por pasillos, una repisa y un estante tienen mas de un producto entonces?
(                                 
     clave numeric NOT NULL,
     cantidad numeric NOT NULL,
     fk_evento numeric,
     fk_zona numeric,
     CONSTRAINT pk_clave_inventario PRIMARY KEY (clave),
     CONSTRAINT fk_fk_evento_inventario FOREIGN KEY (fk_evento) REFERENCES evento(clave),
     CONSTRAINT fk_fk_zona_inventario   FOREIGN KEY (fk_zona) REFERENCES zona(clave)
);

CREATE TABLE public.tipo_pago_credito //Agregue cvc, y no se si agregar, nombre impreso en la tarjeta, y cedula, tanto aqui como en debito (donde tambien se deberia agregar el CVC)
(
     codigo numeric NOT NULL,
     banco varchar(15),
     numero numeric NOT NULL,
     tipo varchar(10) NOT NULL,
     cvc numeric NOT NULL,
     CONSTRAINT pk_codigo_tipo_pago_credito PRIMARY KEY (codigo),
     CONSTRAINT chk_tipo_tipo_pago_credito CHECK (tipo in('Visa','Mastercard'))
);

CREATE TABLE public.tipo_pago_debito
(
     codigo numeric NOT NULL,
     banco varchar(15),
     numero numeric NOT NULL,
     tipo varchar(10) NOT NULL,
     CONSTRAINT pk_codigo_tipo_pago_debito PRIMARY KEY (codigo),
     CONSTRAINT chk_tipo_tipo_pago_debito CHECK (tipo in('Maestro'))
);

CREATE TABLE public.tipo_pago_efectivo     //Revisar FK de TODOS tipo_pago
(
     codigo numeric NOT NULL,
     banco varchar(15),
     denominacion numeric NOT NULL,
     cantidad numeric NOT NULL,
     CONSTRAINT pk_codigo_tipo_pago_efectivo PRIMARY KEY (codigo)
);

CREATE TABLE public.tipo_pago_cheque
(
     codigo numeric NOT NULL,
     banco varchar(15),
     numero_cuenta numeric NOT NULL,
     numero_cheque numeric NOT NULL,
     CONSTRAINT pk_codigo_tipo_pago_cheque PRIMARY KEY (codigo)
);

CREATE TABLE public.historico_tasa //Fecha fin deberia poder ser nulo
(
     clave numeric NOT NULL,
     numero_cambio numeric NOT NULL,
     fecha_inicio date NOT NULL,
     fecha_fin date,
     CONSTRAINT pk_clave_historico_tasa PRIMARY KEY (clave)
)

CREATE TABLE public.tipo_pago_divisa  
(
     codigo numeric NOT NULL,
     banco varchar(15),
     tipo varchar(10) NOT NULL,
     fk_historico_tasa numeric NOT NULL,
     CONSTRAINT pk_codigo_tipo_pago_divisa PRIMARY KEY(codigo,
     CONSTRAINT fk_fk_historico_tasa_tipo_pago_divisa FOREIGN KEY (fk_historico_tasa) REFERENCES historico_tasa(clave)
);

CREATE TABLE public.historico_valor_puntos //Aqui cambiare un par de cosas, en vez de cantidad se colocaria numero_cambio o razon_cambio, y cantidad iria a la parte tipo_pago, algo similar deberia suceder con divisa, este es un cambio a discutir, porque es una modificacion a discutir
(
     clave numeric NOT NULL,
     numero_cambio numeric NOT NULL,
     fecha_inicio date NOT NULL,
     fecha_fin date,
     CONSTRAINT pk_clave_historico_tasa PRIMARY KEY (clave)
);


CREATE TABLE public.tipo_pago_puntos  
(
     codigo numeric NOT NULL,
     banco varchar(15),
     tipo varchar(10) NOT NULL,
     fk_historico_valor_puntos numeric NOT NULL,
     CONSTRAINT pk_codigo_tipo_pago_puntos PRIMARY KEY (codigo),
     CONSTRAINT fk_fk_historico_valor_puntos_tipo_pago_puntos FOREIGN KEY (fk_historico_tasa) REFERENCES historico_valor_puntos(clave)
);

CREATE TABLE public.cuota_afiliacion  //Cambie cantidad a inversion porque se ve mas lindo, adicional a esto, la cardinalidad entre pago y cuota deberia ser a uno, una cuota deberia cancelarse en un pago, teoricamente
(
     clave numeric NOT NULL,
     inversion numeric NOT NULL,
     fecha date NOT NULL,
     fk_proveedor numeric NOT NULL,
     CONSTRAINT pk_clave_cuota_afiliacion PRIMARY KEY (clave)
);

CREATE TABLE public.pago //Borre el atributo fecha compra ya que la fecha esta en la compra como tal, FALTA AGREGAR CUOTA AFILIACION, Y OBLIGATORIEDAD
(
     codigo numeric NOT NULL,
     monto numeric NOT NULL,
     fk_compra numeric,
     fk_tipo_pago_credito numeric,
     fk_tipo_pago_debito numeric,
     fk_tipo_pago_cheque numeric,
     fl_tipo_pago_efectivo numeric,
     fk_tipo_pago_puntos numeric,
     fk_tipo_pago_divisa numeric,
     fk_cuota_afiliacion numeric,
     CONSTRAINT pk_codigo_pago PRIMARY KEY (codigo),
     CONSTRAINT fk_fk_tipo_pago_credito_pago FOREIGN KEY (fk_tipo_pago_credito) REFERENCES tipo_pago_credito(codigo),
     CONSTRAINT fk_fk_tipo_pago_debito_pago FOREIGN KEY (fk_tipo_pago_debito) REFERENCES tipo_pago_debito(codigo),
     CONSTRAINT fk_fk_tipo_pago_cheque_pago FOREIGN KEY (fk_tipo_pago_cheque) REFERENCES tipo_pago_cheque(codigo),
     CONSTRAINT fk_fk_tipo_pago_efectivo_pago FOREIGN KEY (fk_tipo_pago_efectivo) REFERENCES tipo_pago_efectivo(codigo),
     CONSTRAINT fk_fk_tipo_pago_puntos_pago FOREIGN KEY (fk_tipo_pago_puntos) REFERENCES tipo_pago_puntos(codigo),
     CONSTRAINT fk_fk_tipo_pago_divisa_pago FOREIGN KEY (fk_tipo_pago_divisa) REFERENCES tipo_pago_divisa(codigo),
     CONSTRAINT fk_fk_cuota_afiliacion_pago FOREIGN KEY (fk_cuota_afiliacion) REFERENCES cuota_afiliacion(clave)
);

CREATE TABLE public.status
(
     clave numeric NOT NULL,
     nombre varchar NOT NULL,
     CONSTRAINT pk_clave_status PRIMARY KEY (clave)
);

CREATE TABLE public.status_compra
(
     clave numeric NOT NULL,
     fecha_cambio date NOT NULL,
     fk_status numeric NOT NULL,
     fk_compra numeric NOT NULL,
     fk_departamento numeric NOT NULL,
     CONSTRAINT pk_clave_status PRIMARY KEY (clave),
     CONSTRAINT fk_fk_status_status_compra FOREIGN KEY (fk_status) REFERENCES status(clave),
     CONSTRAINT fk_fk_compra_status_compra FOREIGN KEY (fk_compra) REFERENCES compra(clave),
     CONSTRAINT fk_fk_departamento_status_compra FOREIGN KEY (fk_departamento) REFERENCES departamento(clave)
);

CREATE TABLE public.descuento   //Cambie fecha, a fecha_inicio, deberiamos colocar un atributo que sea porcentaje, que sea el porcentaje de descuento, y registrar con precio o porcentaje
(                               // Se quita la relacion con rol?
     clave numeric NOT NULL,
     fecha_inicio date NOT NULL,
     precio numeric NOT NULL,
     fk_cerveza numeric NOT NULL,
     CONSTRAINT pk_clave_status PRIMARY KEY (clave),
     CONSTRAINT fk_fk_cerveza_descuento FOREIGN KEY (fk_cerveza) REFERENCES cerveza_artesanal(clave),
     CONSTRAINT fk_fk_rol_descuento FOREIGN KEY (fk_rol) REFERENCES rol(clave)
);

