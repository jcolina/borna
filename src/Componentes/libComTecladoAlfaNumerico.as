// ActionScript file
// ActionScript file
import Classes.FinalizarEtapa;

import Componentes.Agenda.modAgenda;

import Util.PopUpUtils;

import flash.events.MouseEvent;

import mx.core.Application;
import mx.events.EffectEvent;

/*

private var _objTextInput:TextInput;

public function set objTextInput(_objTextInput:TextInput):void{
	this._objTextInput = _objTextInput;
}

public function get objTextInput():TextInput{
	return this._objTextInput;
}

*/
public var ObjFina:FinalizarEtapa;
public var ObjAgenda:modAgenda;
public static var opcion:int;

private function initCom():void{
	/*
	this.x = this.objTextInput.x;
	this.y = this.objTextInput.y + this.objTextInput.height;
	*/
	
	this.x = PopUpUtils.x;
	this.y = PopUpUtils.y /* + PopUpUtils.objTextInput.height*/;
	//PopUpUtils.objTextInput.selectionBeginIndex(PopUpUtils.objTextInput.text.length);
	//PopUpUtils.objTextInput.selectionEndIndex = PopUpUtils.objTextInput.text.length;
	//Application.application.objTeclado= this;
	this.visible = true;
}

private function onClickButton(event:MouseEvent):void{
	if(event.currentTarget.label == "ESPACIO"){
		txtDatosConfirmacion.text += " ";
	}
	else {
	txtDatosConfirmacion.text += event.currentTarget.label;
	}
}

private function onClickButtonBorrar(event:MouseEvent):void{
	if(txtDatosConfirmacion.text != ""){
		txtDatosConfirmacion.text = txtDatosConfirmacion.text.substr(0, txtDatosConfirmacion.text.length - 1);
	}
}
private function finEtapaCodigo():void{
	if(opcion == 1){
		Application.application.objFinali.codigo = txtDatosConfirmacion.text;
		Application.application.objFinali.finalizarEtapa();
		Application.application.objFinali.objTecladoAlfaNum = this;
	}
	else{
		Application.application.objFinalizar.codigo = txtDatosConfirmacion.text;
		Application.application.objFinalizar.finalizarEtapa();
		Application.application.objFinalizar.objTecladoAlfaNum = this;
	}	
}

private function closePopUp(event:EffectEvent):void{
	PopUpUtils.closePopUpTeclado();
}
private function ingresaCodigo():void{
	Application.application.codigoTrabajador = txtDatosConfirmacion.text; 	
}