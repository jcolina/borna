package Componentes.Agenda.classes.utils
{
	import Componentes.Agenda.comNotificar;
	import Componentes.Agenda.mxml_views.disableHourCell;
	import Componentes.Agenda.mxml_views.hourCell;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.controls.DateField;
	import mx.core.Application;
	
	/**
	 * COMMON UTILS CLASS CONATINS ALL COMMON FUNCTIONS/VARIABLES
	 * WHICH COULD BE USED BY DIFFERENT CLASSES OR VIEWS
	*/
	
	public class CommonUtils
	{			
		public static const TOTAL_DAYS_WEEK:int = 6;		
		public static const DIA_MILISECONDS:Number = 86400000;
		public static const HORA_MILISECONDS:Number = 3600000;
		public static const SEMANA_MILISECONDS:Number = DIA_MILISECONDS * (TOTAL_DAYS_WEEK + 1);	
		
		// Constructor 
		public function CommonUtils()
		{
		}
				
		/**
		 * creates right strip which shows buttons in week and day view. which allow user to set
		 * some new events on a particular time.
		*/
		public static function createRightHourStrip(_parent:Canvas, arrDatos:ArrayCollection, maxDias:int):void
		{
			//en vez de crear todos los cuadros del día, creamos solo
			//en los días que hayan datos, si no, asignamos una casilla desactivada
			
			//Se asigna que como minimo para mostar las celdas deben tener una cantidad de 9 
			//por dia, si es mayor todas las celdas se deben ajustar a la mayor con casillas
			//desactivadas
			
			maxDias < 9 ? maxDias = 9 : null;
			
			if(arrDatos.length > 0){		
						
				for(var i:int=0; i < maxDias; i++){		
								
					if(i + 1 <= arrDatos.length){					
						var objHourCell:hourCell = new hourCell();
						objHourCell.y = objHourCell.height * i;
						objHourCell.horizontalScrollPolicy = "off";
						objHourCell.verticalScrollPolicy = "off";
						_parent.addChild(objHourCell);
				
					objHourCell.data = {
											IDVehiculo: arrDatos[i].IDVehiculo,
											Patente: arrDatos[i].Patente,
											Marca: arrDatos[i].Marca,
											Modelo: arrDatos[i].Modelo,
											Siniestro: arrDatos[i].Siniestro,
											Cono: arrDatos[i].Cono,
											EtapaActual: arrDatos[i].EtapaActual,
											IDEtapa: arrDatos[i].IDEtapa,
											Entrega: arrDatos[i].Entrega
										
											};				
							
						
						var obj:Object = arrDatos[i];
																											
						if(isMenorDate(obj.Entrega)){
							objHourCell.lblPatente.setStyle("color", 0xff0101);
						}
						objHourCell.fecha = obj.Entrega;
 						objHourCell.marca = obj.Marca;
 						objHourCell.patente = obj.Patente;
 						objHourCell.etapa = obj.EtapaActual;
						objHourCell.modelo = obj.Modelo;
						objHourCell.IDeta = obj.IDEtapa;
						objHourCell.IDvehi = obj.IDVehiculo;
						objHourCell.lblPatente.text = obj.Patente  + " " + obj.EtapaActual;
						objHourCell.lblFecha.text = "Entrega: " + obj.Entrega  ;
						if(obj.Marca != null && obj.Modelo != null){
							objHourCell.lblMarca.text = obj.Marca  + " " + obj.Modelo ;
						}else{
							objHourCell.lblMarca.text = "Marca y Modelo No Registrado";
						}
																
						var infoToolTip:String = "Marca: " + obj.Marca + "\n" +
												"Modelo: " + obj.Modelo + "\n" +
												"Fecha Entrega: " + obj.Entrega + "\n" +
												"Siniestro: " + obj.Siniestro;						 	 																	
						
						objHourCell.lblPatente.toolTip = infoToolTip;															  
						objHourCell.lblFecha.toolTip = infoToolTip;															  
						objHourCell.lblMarca.toolTip = infoToolTip;															  
						objHourCell.toolTip = infoToolTip;															  
						objHourCell.addEventListener(MouseEvent.CLICK, onDayViewClick);		
								
					}else{
						createDisableHour(_parent, i);
					}					
				}
			}else{
				for(var x:int=0; x < maxDias; x++){
					createDisableHour(_parent, x);
				}
			}
		}
				
		/**
		 * Crea los cuadros desactivados (en plomo)
		*/
		private static function createDisableHour(_parent:Canvas, index:int):void {
			var objDisableHourCell:disableHourCell = new disableHourCell();
			objDisableHourCell.y = objDisableHourCell.height * index;
			_parent.addChild(objDisableHourCell);
		}	
		
		/**
		 * Funciones para trabajar las fechas
		*/		
		public static function stringToDate(date:String):Date {
			return new Date(DateField.stringToDate(date, "DD-MM-YYYY").getTime() + HORA_MILISECONDS);
		}
		
		public static function setHour(milisecondsDate:Number):Number {
			var dtHora:Date = new Date(milisecondsDate);
			dtHora.setHours(01,00,00);
			return dtHora.getTime();
		}
		
		public static function isCompareDate(fechaInicio:Number, fechaComparar:String, fechaTermino:Number):Boolean {
			var dtComparar:Number =  setHour(stringToDate(fechaComparar).getTime());
			fechaInicio = setHour(fechaInicio);
			fechaTermino = setHour(fechaTermino);
			
			//Comparamos que la fecha este dentro de la semana y el día
			if(dtComparar >= fechaInicio &&  dtComparar <= fechaTermino){
				 return true;
			}
			return false;
		}
		
		public static function isMenorDate(fechaComparar:String):Boolean {
			var dtComparar:Number =  setHour(stringToDate(fechaComparar).getTime());
			var dtPresentDateTemp:Date = new Date();
			var dtPresentDate:Number = setHour(stringToDate(dtPresentDateTemp.getDate().toString() + "-" + (dtPresentDateTemp.getMonth() + 1).toString() + "-" + dtPresentDateTemp.getFullYear().toString()).getTime());
			
			//Comparamos que la fecha este dentro de la semana y el día
			if(dtComparar < dtPresentDate){
				 return true;
			}
			return false;
		}
		
		public static function getDayName(_intDayNumber:int):String
		{
			_intDayNumber++;
			switch (_intDayNumber)
			{
				case 1:
					return "Sunday";
					break;
				case 2:
					return "Monday";
					break;
				case 3:
					return "Tuesday";
					break;
				case 4:
					return "Wednesday";
					break;
				case 5:
					return "Thursday";
					break;
				case 6:
					return "Friday";
					break;
				case 7:
					return "Saturday";
					break;
				default:
					return "no day";
			}
		}
			
		/**
		 * Click event of buttons of First and Second half of a hour
		 * set various values like hour, meridiem, date 
		 * these values are used by Event Form 
		*/
		private static function onDayViewClick(event:MouseEvent):void {
			var objHourCell:hourCell;
			var objComNotificar:comNotificar = new comNotificar();
						
			if(event.target.toString().indexOf("lblPatente") != -1 || event.target.toString().indexOf("lblFecha") != -1 || event.target.toString().indexOf("lblMarca") != -1) {
				objHourCell = hourCell(event.target.parent.parent.parent);				
			}else{
				if(event.target.toString().indexOf("cnvPatente") != -1 || event.target.toString().indexOf("cnvFecha") != -1 || event.target.toString().indexOf("cnvMarca") != -1) {
					objHourCell = hourCell(event.target.parent);
				}
			}
			
			//Por si selecciona fuera de los campos y el objeto hora queda nulo
			

				comNotificar.Etapa = objHourCell.etapa;
				comNotificar.idEtapa = objHourCell.IDeta;
				comNotificar.IdVehiculo = objHourCell.IDvehi;
				comNotificar.Modelo = objHourCell.modelo;
				comNotificar.Patente = objHourCell.patente;
				comNotificar.Marca = objHourCell.marca;
				comNotificar.Fecha = objHourCell.fecha;

				Application.application.showPopUpAgenda(objComNotificar);
				
						
		}
	}
}