package Componentes.Agenda.classes.views
{
	import Componentes.Agenda.classes.model.DataHolder;
	import Componentes.Agenda.classes.utils.CommonUtils;
	import Componentes.Agenda.mxml_views.weekCell;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.controls.scrollClasses.ScrollBar;

	/**
	 * THIS CLASS WILL ALLOW TO GENERATE A LIST OF HOUR CELLS
	 * WHICH WILL BE FROM 00hr. TO 24hr. AND THIS LIST WILL BE GENERATED FOR 7 DAYS IN CURRENT WEEK
	 * 
	 * THIS CLASS USES hourCell TO GENERATE THE LIST. IT READ CURRENT DATE TO GENERATE
	 * THE VIEW FOR THAT PARTICULAR WEEK.
	 * 
	 * ADDITIONALLY IT CONNECTS WITH DATA HOLDER AND CHECK FOR EVENT EXISTENSE FOR A PARTICULAR
	 * DATE AND GENERATE THE VIEW ACCORDINGLY.  
	 * 
	 * THIS CLASS IS EXTENDED TO CANVAS SO IT COULD BE USED A DISPLAY OBJECT IN MXML FILES AS WELL.
	 * 
	 * Modificado por Max Moreno - 28-06-2011
	 * 
	 * Cambios:
	 * 	- Ahorro de código
	 * 	- Compatibilidad con cambio de horario chileno
	 * 
	*/

	public class WeekView extends Canvas
	{	
		
		private var lastGeneratedDate:Date;				
		private var m_currentDate:Date;
		private var maxDatosDia:int;
		private var maxDatosDiaTemp:int;
		
		public function set currentDate(_currentDate:Date):void {
			m_currentDate = new Date(_currentDate.getTime());
			createIntialChildren();
		}
		
		public function get currentDate():Date {
			return m_currentDate;
		}
		
		public function set latsDate(_currentDate:Date):void {
			lastGeneratedDate = _currentDate
		}
		
		public function get latsDate():Date {
			return lastGeneratedDate;
		}
				
		public function WeekView() {
			super();	
			//ScrollBar.THICKNESS = 30;		
		}
		
		private function createIntialChildren():void {	
			var intStartDate:int;
			var intEndDate:int;
			var dtEndWeek:Date;			
			var arrDatosSemana:ArrayCollection;
			var arrDatosDia:ArrayCollection;
			
			//Verificamos que la fecha que viene no se haya consultado dos veces seguidas
			//y que no venga nula
			if(lastGeneratedDate != currentDate && currentDate != null) {
				//Calculamos el primer día de la semana
				intStartDate = currentDate.getDate() - currentDate.getDay();				
				currentDate.setDate(intStartDate);
				
				//Calculamos el ultimo día de la semana
				intEndDate = currentDate.getDate() + (CommonUtils.TOTAL_DAYS_WEEK - currentDate.getDay());
				dtEndWeek = new Date(currentDate.getFullYear(), currentDate.getMonth(), intEndDate);
								
				//guardamos la última fecha para luego compararla 
				lastGeneratedDate = currentDate;
					
				// now generate view as per week dates
				this.removeAllChildren();
				//creción y agregación del contenedor de las horas
				var objHourContainer:Canvas = new Canvas();
				objHourContainer.horizontalScrollPolicy = "off";
				objHourContainer.verticalScrollPolicy = "off";
				this.addChild(objHourContainer);
				objHourContainer.y = 22;
				
				var objWeekCellContainer:Canvas = new Canvas();				
				this.addChild(objWeekCellContainer);
				objWeekCellContainer.x = 0;
				objWeekCellContainer.width = 1250;
				objWeekCellContainer.verticalScrollPolicy = "off";
				objWeekCellContainer.horizontalScrollPolicy = "off";
				objWeekCellContainer.name = "objWeekCellContainer";
				
				//sacamos los datos correspondientes a la semana del objeto DataHolder
				arrDatosSemana = new ArrayCollection();		
				//Alert.show(ObjectUtil.toString(arrDatosSemana));
				if(DataHolder.getInstance().dataProvider != null){
					for(var i:int = 0; i < DataHolder.getInstance().dataProvider.length; i++){						
						if(CommonUtils.isCompareDate(currentDate.getTime(), DataHolder.getInstance().dataProvider[i].Entrega, currentDate.getTime() + CommonUtils.SEMANA_MILISECONDS)){
							arrDatosSemana.addItem(DataHolder.getInstance().dataProvider[i]);
						}
					}
					
					//Setamos los datos de la semana para exportar a excel
					DataHolder.getInstance().arrDatosSemana = arrDatosSemana;
					
					maxDatosDia = 0;
					//calculamos el día que tiene mas datos y lo guardamos en maxDatosDia
					//esto para la creación de los recuadros con los datos
					for(var x:int = 0; x < arrDatosSemana.length; x++){
						maxDatosDiaTemp = 0;
						for(var y:int = 0; y < arrDatosSemana.length; y++){
							if(arrDatosSemana[y].date == arrDatosSemana[x].Entrega){
								maxDatosDiaTemp++;
							}
						}
						if(maxDatosDiaTemp > maxDatosDia){
							maxDatosDia = maxDatosDiaTemp;
						}
					}			
					
					// generate hour strip for seven daya i.e. number of days in a week
					//se crea la cabecera con el nombre del día y se crean todas las celdas para ese día
					for(var j:int = 0; j <= CommonUtils.TOTAL_DAYS_WEEK; j++) {						
						//sacamos los datos correspondientes al día
						arrDatosDia = new ArrayCollection();
						
						for(var z:int = 0; z < arrDatosSemana.length; z++){							
							if(CommonUtils.isCompareDate(currentDate.getTime() , arrDatosSemana[z].Entrega, currentDate.getTime())){
								arrDatosDia.addItem(arrDatosSemana[z]);
							}						
						}
						
						var objWeekCell:weekCell = new weekCell();
						objWeekCellContainer.addChild(objWeekCell);
						objWeekCell.x = objWeekCell.width * j;				
						objWeekCell.lblDate.text = String(currentDate.date) + "    " + nombreDia(CommonUtils.getDayName(currentDate.day).substr(0, 3));
						
						// generate hour strip from common functions
						//se envian todos los datos del dia y se crea
						CommonUtils.createRightHourStrip(objWeekCell.canDayView, arrDatosDia, maxDatosDia);
						
						currentDate.date = currentDate.date + 1;
					}
				}
			}			
		}
						
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void	{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
		}	
		
			
		
		private function nombreDia(dia:String):String {
			switch(dia.toUpperCase()){
				case "MON":
					return "Lunes";
		        break;
		        case "TUE":
					return "Martes";
		        break;
		        case "WED":
					return "Miércoles";
		        break;
		        case "THU":
					return "Jueves";
		        break;
		        case "FRI":
					return "Viernes";
		        break;
		        case "SAT":
					return "Sábado";
		        break;
		        case "SUN":
					return "Domingo";
		        break;		        
			}
			return null;
		}
	}
}