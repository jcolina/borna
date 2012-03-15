// ActionScript file
import Classes.FinalizarEtapa;

import mx.core.Application;



public var objFinalizaEtapa:FinalizarEtapa;

private function initCom():void{
	this.objFinalizaEtapa = new FinalizarEtapa(this);
	}

private function finalizarEtapa():void{
	Application.application.objFinalizar=this.objFinalizaEtapa;
	this.objFinalizaEtapa.finalizarEtapa2();
	//this.objFinalizaEtapa.finalizarEtapa();
}

private function finalizarEtapa2():void{
	//this.objFinalizaEtapa
	this.objFinalizaEtapa.finalizarEtapa2();
}
