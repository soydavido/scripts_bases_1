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
     CONSTRAINT pk_clave_lager PRIMAY KEY (clave)
);

CREATE TABLE public.ingrediente
(
     id numeric NOT NULL,
     nombre varchar(15) NOT NULL,
     tipo varchar(15) NOT NULL,
     CONSTRAINT pk_id_ingrediente PRIMARY KEY (id)
);

CREATE TABLE public.receta    //ESTA CREACION NO PUEDE ESTAR AQUI, SE TIENE QUE ACOMODAR
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

CREATE TABLE public.caracteristica      //LO MAS PROBABLE ES QUE DEBA SER MODIFICADA
(
     clave numeric NOT NULL,
     tipo varchar(15) NOT NULL,
     valor varchar(15) NOT NULL
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

CREATE TABLE public.instruccion
(
     clave numeric NOT NULL,
     descripcion varchar(80) NOT NULL,
     fk_cerveza_artesanal numeric NOT NULL,
     CONSTRAINT pk_clave_instruccion PRIMARY KEY (clave),
     CONSTRAINT fk_fk_cerveza_artesanal_instruccion FOREIGN KEY (fk_cerveza_artesanal) REFERENCES cerveza_artesanal(clave)
);


CREATE TABLE public.cerveza_caracteristica  //No se colocan clave compuestas, se coloca un id en la tabla y solo se usan las fk
(
     id numeric NOT NULL,
     fk_cerveza numeric NOT NULL,
     fk_caracteristica numeric NOT NULL,
     CONSTRAINT pk_id_cerveza_caracteristica PRIMARY KEY (id),
     CONSTRAINT fk_fk_cerveza_cercar FOREIGN KEY (fk_cerveza) REFERENCES cerveza_artesanal(clave),
     CONSTRAINT fk_fk_caracteristica FOREIGN KEY (fk_caracteristica) REFERENCES caracteristica(clave)
);

CREATE TABLE public.departamento
(
     clave numeric NOT NULL,
     nombre varchar(20) NOT NULL
);

CREATE TABLE public.direccion
(
     clave numeric NOT NULL,
     tipo varchar(10) NOT NULL,
     nombre varchar(1) NOT NULL,
     fk_direccion numeric,
     CONSTRAINT  fk_fk_direccion FOREIGN KEY (fk_direccion) REFERENCES lugar(clave),
     CONSTRAINT chk_tipo_direccion CHECK (tipo in ('Continente','Pais','Estado','Municipio','Parroquia') ) 
);

CREATE TABLE public.rol
(
     clave numeric NOT NULL,
     nombre varchar(13) NOT NULL,
     tipo varchar(13) NOT NULL,
     
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
     fecha_inicio date NOT NULL,
     fecha_fin date,
     tipo varchar(10),
     fk_personal numeric NOT NULL,
     CONSTRAINT chk_tipo_horario CHECK (tipo in ('Vacaciones','Motivos Familiares','Motivos de salud') ),
     CONSTRAINT fk_fk_personal_horario FOREIGN KEY (fk_personal) REFERENCES personal(clave)
);

CREATE TABLE public.proveedor
(
     rif numeric NOT NULL,
     razon_social varchar NOT NULL,
     denominacion_comercial varchar NOT NULL,
     pagina_web varchar NOT NULL,
     CONSTRAINT pk_rif_proveedor PRIMARY KEY (rif)
);

CREATE TABLE public.proveedor_direccion
(
     codigo numeric NOT NULL,
     fk_proveedor numeric NOT NULL,
     fk_direccion numeric NOT NULL,
     CONSTRAINT pk_codigo_proveedor_direccion PRIMARY KEY (codigo),
     CONSTRAINT fk_fk_proveedor_proveedor_direccion FOREIGN KEY (fk_proveedor) REFERENCES proveedor(rif),
     CONSTRAINT fk_fk_direccion_proveedor_direccion FOREIGN KEY (fk_direccion) REFERENCES direccion(clave)
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
     virtual_pagina_web varchar,
     CONSTRAINT pk_tienda PRIMARY KEY (clave)
)

CREATE TABLE public.zona   //Revisar la relacion con cerveza, ya que esta se puede conseguir a traves de inventario, relacion innecesaria
(
     clave numeric NOT NULL,
     numero_estante numeric NOT NULL,
     numero_repisa numeric NOT NULL,
     fk_tienda numeric NOT NULL,
     fk_rol numeric NOT NULL,
     CONSTRAINT pk_zona PRIMARY KEY (clave),
     CONSTRAINT fk_fk_tienda_zona FOREIGN KEY (fk_tienda) REFERENCES tienda(clave),
     CONSTRAINT fk_fk_rol_zona FOREIGN KEY (fk_rol) REFERENCES rol(clave)
);

CREATE TABLE public.venta         //Podriamos evitarnos el atributo codigo y usar como pk el atributo nro_factura
(                                 // Hay que revisar la relacion de esta entidad con historico_venta, ya que un detalle solo vendria de un historico
     codigo numeric NOT NULL,
     total numeric NOT NULL,
     nro_factura numeric NOT NULL,
     fecha date NOT NULL,
     CONSTRAINT pk_codigo_venta PRIMARY KEY (codigo)
);

CREATE TABLE public.historico_inventario_cerveza
(
     clave numeric NOT NULL,
     cant_disponible numeric NOT NULL,
     fecha_inicio date NOT NULL,
     fk_cerveza numeric NOT NULL,
     fecha_fin date,
     fk_detalle_venta numeric,
     fk_detalle_compra numeric,
     CONSTRAINT pk_clave_historico_inventario_cerveza PRIMARY KEY (clave),
     CONSTRAINT fk_fk_cerveza FOREIGN KEY (fk_cerveza) REFERENCES cerveza_artesanal(clave),
     CONSTRAINT fk_fk_detalle_compra_historico_inventario FOREIGN KEY (fk_detalle_compra) REFERENCES detalle_compra(clave),
     CONSTRAINT fk_fk_detalle_venta_historico_inventario FOREIGN KEY(fk_detalle_venta) REFERENCES detalle_venta(codigo)
);

CREATE TABLE public.detalle_venta     // A su vez, un historico inventario no tendria un solo inventario? La relacion no deberia ser uno a uno?
(
     codigo numeric NOT NULL,
     cantidad numeric NOT NULL,
     fk_venta numeric NOT NULL,
     fk_historico_inventario numeric NOT NULL,
     CONSTRAINT pk_codigo_detalle_venta PRIMARY KEY (codigo),
     CONSTRAINT fk_fk_venta_detalle_venta FOREIGN KEY (fk_venta) REFERENCES venta(codigo),
     CONSTRAINT fk_fk_historico_inventario_detalle_venta FOREIGN KEY (fk_historico_inventario) REFERENCES historico_inventario_cerveza(clave)
);

CREATE TABLE public.cliente 
(
     rif(13) numeric NOT NULL,
     tipo varchar(8) NOT NULL,
     natural_ci numeric(9),
     natural_nombre varchar(15),
     natural_apellido varchar(15),
     juridico_denominacion_comercial varchar(20),
     juridico_razon_social varchar(20),
     juridico_pagina_web varchar(20),
     juridico_capital numeric,
     CONSTRAINT pk_cliente PRIMARY KEY (rif)
     CONSTRAINT chk_tipo_cliente CHECK (tipo in ('Natural','Juridico'))
);

CREATE TABLE public.cliente_direccion
(
     codigo numeric NOT NULL,
     fk_cliente numeric NOT NULL,
     fk_direccion numeric NOT NULL,
     CONSTRAINT pk_codigo_cliente_direccion PRIMARY KEY (codigo),
     CONSTRAINT fk_fk_cliente_cliente_direcion FOREIGN KEY (fk_cliente) REFERENCES cliente(rif),
     CONSTRAINT fk_fk_direccion_cliente_direccion FOREIGN KEY (fk_direccion) REFERENCES direccion(clave)
);

CREATE TABLE public.historico_puntos_cliente
(
     clave numeric NOT NULL,
     cantidad numeric NOT NULL,
     fecha_cambio date NOT NULL,
     fk_cliente numeric NOT NULL,
     CONSTRAINT pk_clave_historico_puntos_cliente PRIMARY KEY (clave),
     CONSTRAINT fk_fk_cliente_historico_puntos_cliente FOREIGN KEY (fk_cliente) REFERENCES cliente(rif)
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

CREATE TABLE pubic.evento
(
     clave numeric NOT NULL,
     nombre varchar NOT NULL,
     precio_entrada numeric NOT NULL,
     cant_entrada_disp numeric NOT NULL,
     cant_entrada_vendida varchar NOT NULL,
     fk_direccion numeric NOT NULL,
     CONSTRAINT pk_clave_evento PRIMARY KEY (clave),
     CONSTRAINT fk_fk_direccion_evento FOREIGN KEY (fk_direccion) REFERENCES direccion(clave)
);

CREATE TABLE public.inventario     //Una zona no deberia tener un solo inventario? No se guarda historico por pasillos
(                                 
     clave numeric NOT NULL,
     cantidad numeric NOT NULL,
     fk_evento numeric,
     fk_zona numeric,
     CONSTRAINT pk_clave_inventario PRIMARY KEY (clave),
     CONSTRAINT fk_fk_evento_inventario FOREIGN KEY (fk_evento) REFERENCES evento(clave),
     CONSTRAINT fk_fk_zona_inventario   FOREIGN KEY (fk_zona) REFERENCES zona(clave)
);

CREATE TABLE public.tipo_pago_credito
(
     codigo numeric NOT NULL,
     banco varchar(15),
     numero numeric NOT NULL,
     tipo varchar(10) NOT NULL,
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

CREATE TABLE public.detalle_compra //Se debe evaluar la posibilidad de eliminar la clave y utilizar numero_factura como la PK de la tabla, no coloque el atributo tipo porque no se que tipo puede ser, la carndinalidad de las FK esta mal, no puede ser doble mandatoria, deberia ser opcional
(
     clave numeric NOT NULL,
     total_pago numeric NOT NULL,
     numero_factura numeric NOT NULL,
     fecha date NOT NULL,
     fk_cliente numeric NOT NULL,
     fk_tienda_fisica numeric,
     fk_tienda_virtual numeric,
     CONSTRAINT pk_clave_detalle_compra PRIMARY KEY (clave),
     CONSTRAINT fk_fk_cliente_detalle_compra FOREIGN KEY (fk_cliente) REFERENCES cliente(rif),
     CONSTRAINT fk_fk_tienda_fisica_detalle_compra FOREIGN KEY (fk_tienda_fisica) REFERENCES tienda(clave),
     CONSTRAINT fk_fk_tienda_virtual_detalle_compra FOREIGN KEY (fk_tienda_virtual) REFERENCES tienda(clave)
);

CREATE TABLE public.pago //Borre el atributo fecha compra ya que la fecha esta en la compra como tal. hay que reisar el funcionamiento de esta entidad
(
     codigo numeric NOT NULL,
     monto numeric NOT NULL,
     descripcion varchar(50), 
     fk_compra numeric NOT NULL,
     fk_tipo_pago numeric NOT NULL,
     CONSTRAINT pk_codigo_pago PRIMARY KEY (codigo)
)
