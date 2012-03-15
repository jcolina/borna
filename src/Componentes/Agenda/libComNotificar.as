// ActionScript file
import Classes.FinalizarEtapa;
import Componentes.Agenda.FinalizaEta;
import Componentes.comTecladoAlfaNumerico;

import mx.core.Application;

public var objFinalizar:FinalizaEta;

public static var Patente:String;
public static var Modelo:String;
public static var Etapa:String;	
public static var Marca:String;
public static var Fecha:String;
public static var IdVehiculo:String;
public static var idEtapa:String;

private function initCom():void {
	this.objFinalizar = new FinalizaEta(this);
	this.lblMarca.text=Marca;
	this.lblFecha.text=Fecha;
	this.lblPatente.text=Patente;	
	this.lblModelo.text=Modelo;	
	this.lblEtapa.text=Etapa;	

}

private function finalizarEtapa():void{
	
	cargaObjetoApp();
	this.objFinalizar.finalizarEtapa2();
	//this.objFinalizaEtapa.finalizarEtapa();
	this.visible = false;
}
private function finalizarEtapa2():void{
	//this.objFinalizaEtapa
	this.objFinalizar.finalizarEtapa2();
}
public  function cargaObjetoApp():void{
	Application.application.objFinali=this.objFinalizar;
	//FinalizarEtapa.opcion=1;
}