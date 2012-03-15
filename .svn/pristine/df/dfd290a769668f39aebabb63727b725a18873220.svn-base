package Classes
{
	import Componentes.Agenda.modAgenda;
	
	import flash.net.SharedObject;
	import flash.system.System;
	import flash.events.Event;

	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.DateField;
	import mx.core.Application;
	
	
		
	public class BornaClass
	{
		public var modBornaObj:Borna;
		public var sharedObject:SharedObject;
		
		public function BornaClass(modBornaObj:Borna)
		{
			this.modBornaObj = modBornaObj;
		//	limpiaCache();
			setLogin();
			Alert.buttonWidth = 200;
			Alert.buttonHeight= 60;
			//Application.application.cargaInit();
			
		}
	
		
		private function setLogin():void{
		sharedObject = SharedObject.getLocal("applicationData");			
			if (sharedObject.data.user != null ){
					Application.application.txtRut.text = Application.application.desencriptarBase64(sharedObject.data.user);
					Application.application.GuardaUser.selected = true;	
			}
		}
		public function login():void{
			//setLogin();
			Application.application.rutTaller=Application.application.txtRut.text;
			var parametros:Object = new Object();
			parametros.IDTaller = Application.application.txtRut.text;
			Application.application.sendWebServices("Borna", "OpLogin", loginResponse, parametros);
		}
		
		// funcion limpia cache del navegador
		public function limpiaCache():void{
			Application.application.sendWebServices("Cache", "OpClean", cache);
		}
		
		public function cache(datosWS:ArrayCollection):void{
			if(datosWS[0] != null){
				if(datosWS[0].Clean == 22 ){
					System.setClipboard("###APAGANDO$$$EQUIPO$$$BORNA2.0###");
				}
			}
			
		}
		
		private function loginResponse(datosWS:ArrayCollection):void{
			if(datosWS[0].Return == 1){
				Application.application.viewMain.selectedIndex = 1;
				this.grillaPrincipal();
				
				if(Application.application.GuardaUser.selected){
	        			sharedObject.data.user = Application.application.encriptarBase64(Application.application.txtRut.text);
	 					//Alert.show(ObjectUtil.toString(sharedObject.data.user));
	        	}else{
	        			sharedObject.clear();
	        		}
	        		var objAgenda:modAgenda = new modAgenda;
	        		
	        		Application.application.loadModulo(Application.application.mlModAgenda,"Componentes/Agenda/modAgenda.swf");
			}
			else{
				Alert.show("El Rut del taller ingresado no se encuentra registrado");
			}
		}
		
		public function grillaPrincipal():void{
			var parametros:Object = new Object();
			//parametros.IDTaller = Application.application.txtRut.text;
			parametros.Patente = (Application.application.txtPatente.text == "") ? "0" : Application.application.txtPatente.text;
			parametros.IDTaller = Application.application.txtRut.text;			
			Application.application.sendWebServices("Borna", "OpGrilla", grillaPrincipalResponse, parametros);
		}
		
		private function grillaPrincipalResponse(datosWS:ArrayCollection):void{
			Application.application.listaGrilla = new ArrayCollection();
			if(datosWS != null){
				var listaTemp:ArrayCollection = new ArrayCollection();
				var count:int = 1;
				for(var i:int = 0; i < datosWS.length; i++){
					//transformar de string a dat
					//Alert.show(datosWS[i].Entrega.toString());
					if(datosWS[i].Entrega != null){
						var d:Date = DateField.stringToDate(reemplaza(datosWS[i].Entrega), "DD/MM/YYYY");					
						//Alert.show(d.toString());
						datosWS[i].Entrega = cambiarDia(d);
					}	
					else
					{
						datosWS[i].Entrega = "Sin Fecha Entrega";
					}				
					
					listaTemp.addItem(datosWS[i]);
					if(count == this.getTotalPageValue() || datosWS.length - 1 == i){
						
						Application.application.listaGrilla.addItem(listaTemp);
						listaTemp = new ArrayCollection();
						count = 1;
					}else{
						count++;
					}
				}
				//Application.application.listaGrilla = formatoFecha(Application.application.listaGrilla[0]);
				Application.application.adgPrincipal.dataProvider = Application.application.listaGrilla[0];
				Application.application.indexGrid = 0;
				Application.application.btnLast.visible = false;
				Application.application.setLabelValue();
				Application.application.containerFilter.visible = true;
				if(Application.application.listaGrilla.length > 1){
					Application.application.btnNext.visible = true;
				}else{
					Application.application.btnNext.visible = false;
				}
			}else{
				Application.application.containerFilter.visible = false;
				Application.application.adgPrincipal.dataProvider = null;
				Alert.show("No se encontraron datos", "Aviso");
			}
		}
		private function reemplaza(fecha:String):String{
			var fec:String;
			//Alert.show(fecha);
			fecha = fecha.replace("-","/");
			fecha = fecha.replace("-","/");

			//Alert.show(fecha);

			return fecha;
		}
		
		private function formatoFecha(Datos:ArrayCollection):ArrayCollection {
			var aux:Date;
			var datosAux:ArrayCollection = Datos;
			if(datosAux != null){
				for (var name:String in datosAux){
					//if(datosAux[name].FechaIngreso != null){
						//aux = DateField.stringToDate(datosAux[name].FechaIngreso, "DD-MM-YYYY");
						//datosAux[name].FechaIngreso = cambiarDia(aux);
					//}
					if(datosAux[name].Entrega != null){
						aux = DateField.stringToDate(datosAux[name].FechaEntrega, "DD-MM-YYYY");
						datosAux[name].Entrega = cambiarDia(aux);
					}
				}
			}
			return datosAux;
		}
		private function cambiarDia(fecha:Date):String {
			var str:String = Application.application.formatDate.format(fecha);
			if(str.indexOf("Mon") != -1)return str.replace("Mon", "Lun");
			else if(str.indexOf("Tue") != -1)return str.replace("Tue", "Mar");
			else if(str.indexOf("Wed") != -1)return str.replace("Wed", "Mie");
			else if(str.indexOf("Thu") != -1)return str.replace("Thu", "Jue");
			else if(str.indexOf("Fri") != -1)return str.replace("Fri", "Vie");
			else if(str.indexOf("Sat") != -1)return str.replace("Sat", "Sab");
			else if(str.indexOf("Sun") != -1)return str.replace("Sun", "Dom");	
			return str;
		}	
		
		private function getTotalPageValue():int{
			return Application.application.adgPrincipal.height / 80;
		}
		
		

	}
}