// ActionScript file



import Componentes.Agenda.classes.model.DataHolder;
import Componentes.Agenda.classes.utils.CommonUtils;

import mx.collections.ArrayCollection;
import mx.core.Application;
/* Current date will be bound all views */
[Bindable]
private var currentDate:Date;


private function initMod():void {
	cargarDatos();
	//cargarComboRecepcionista();
	
	}		


public function cargarDatos():void {
	var parametrosWS:Object = new Object();
	parametrosWS.Patente = "0";
	parametrosWS.IDTaller=Application.application.rutTaller;
	Application.application.sendWebServices("Borna", "OpGrilla", datosAgenda, parametrosWS);
}

public function datosAgenda(event:ArrayCollection):void {
	
	
	for(var i:int = 0;i < event.length ; i++){
		if(event[i].Entrega == null){
			event[i].Entrega = "Sin fecha de Entrega";
		}
		else{
			event[i].Entrega = event[i].Entrega ;
		}
	}
	
	DataHolder.getInstance().dataProvider = event;
	//DataHolder.getInstance().addEventListener(CustomEvents.ADD_NEW_EVENT, onNewEventAdded);
	presentWeek();
	lblMes.visible = true;
}
private function changeWeek(milisecondsDate:Number):void {
	currentDate = new Date(milisecondsDate);
	weekView.currentDate = currentDate;
	displayMeses();
}

private function nextWeek():void {
	changeWeek(currentDate.getTime() + CommonUtils.SEMANA_MILISECONDS);	
}

private function lastWeek():void {
	changeWeek(currentDate.getTime() - CommonUtils.SEMANA_MILISECONDS);	
}

private function presentWeek():void {
	var dtPresentDate:Date = new Date();
	var dtTemp:Date = new Date(dtPresentDate.getFullYear(), dtPresentDate.getMonth(), dtPresentDate.getDate());
	changeWeek(dtTemp.getTime() + CommonUtils.HORA_MILISECONDS);	
}
  


       
  


		
private function displayMeses():void{
	var mes:String = "";
	
	switch (currentDate.month){
		case 0:
			mes = "Enero";
			break;
		case 1:
			mes = "Febrero";
			break;
		case 2:
			mes = "Marzo";
			break;
		case 3:
			mes = "Abril";
			break;
		case 4:
			mes = "Mayo";
			break;
		case 5:
			mes = "Junio";
			break;
		case 6:
			mes = "Julio";
			break;
		case 7:
			mes = "Agosto";
			break;
		case 8:
			mes = "Septiembre";
			break;
		case 9:
			mes = "Octubre";
			break;
		case 10:
			mes = "Noviembre";
			break;
		case 11:
			mes = "Diciembre";
			break;		
	}
	
	lblMes.text = mes + " " + currentDate.fullYear.toString();
}