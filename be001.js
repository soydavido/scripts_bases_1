
var postgre = require('pg');

module.exports={

	getEventosRecientes: function(req,res,next){

		console.log(req,body);
		var textConsulta = 'SELECT TOP 5 * FROM evento ORDER BY fecha DESC';

		var config = require('../database/config'); //A modificar 
                var db = new postgre.Client(config);
                db.connect();

                db.query(textConsulta, (err,res)){
        	  (err){
        		console.log(err.stack());
        	  }
        	  else{
        		var eventosRecientes = res;
        	  }
        }

        //Aqui se usaria el arreglo de JSON para incorporarlo a la pagina de home

	}

	getProveedoresRecientes: function(req,res,next){

		console.log(req,body);
		var textConsulta = 'SELECT TOP 5 * FROM proveedor ORDER BY codigo DESC';  //Bajo revision el RIF

		var config = require('../database/config');  //A modificar 
                var db = new postgre.Client(config);
                db.connect();

                db.query(textConsulta, (err,res)){
         	  if(err){
        		console.log(err.stack());
        	  }
        	  else{
        		var eventosRecientes = res;
        	  }
                }

               //Aqui se usaria el arreglo de JSON para incorporarlo a la pagina de home
        
	}


        getDescuentosRecientes: function(req,res,next){

                console.log(req,body);
                var textConsulta = 'SELECT TOP 5 * FROM descuento ORDER BY codigo DESC';  //Bajo revision el RIF

                var config = require('../database/config');  //A modificar 
                var db = new postgre.Client(config);
                db.connect();

                db.query(textConsulta, (err,res)){
                  if(err){
                        console.log(err.stack());
                  }
                  else{
                        var eventosRecientes = res;
                  }
                }

               //Aqui se usaria el arreglo de JSON para incorporarlo a la pagina de home
        
        }

}