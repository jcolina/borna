// ActionScript file
import Classes.BornaClass;
import Classes.FinalizarEtapa;
import Classes.UrlServices;

import Componentes.Agenda.FinalizaEta;

import Componentes.comTecladoAlfaNumerico;
import Componentes.comWait;

import Util.PopUpUtils;

import Validaciones.Validar;

import WebServiceClass.WebServicesClass;

import flash.events.MouseEvent;

import mx.collections.ArrayCollection;
import mx.core.Application;
import mx.core.IFlexDisplayObject;
import mx.managers.PopUpManager;
import mx.modules.ModuleLoader;
import mx.utils.Base64Decoder;
import mx.utils.Base64Encoder;

//Variables globales
private var _objWebServiceClass:WebServicesClass;
private var _objUrlServices:UrlServices;
private var _objBorna:BornaClass;
private var _listaGrilla:ArrayCollection;
private var _indexGrid:int;
private var _codigoTrabajador:String;
public var objFinali:FinalizaEta;

public var objFinalizar:FinalizarEtapa;
public var objTeclado:comTecladoAlfaNumerico;
public var rutTaller:String;
public function set indexGrid(_indexGrid:int):void{
	this._indexGrid = _indexGrid;	
}

public function get indexGrid():int{
	return this._indexGrid;
}
public function set codigoTrabajador(_codigoTrabajador:String):void{
	this._codigoTrabajador = _codigoTrabajador;	
}

public function get codigoTrabajador():String{
	return this._codigoTrabajador;
}

public function set listaGrilla(_listaGrilla:ArrayCollection):void{
	this._listaGrilla = _listaGrilla;	
}



public function get listaGrilla():ArrayCollection{
	return this._listaGrilla;
}

public function set objBorna(_objBorna:BornaClass):void{
	this._objBorna = _objBorna;	
}

public function get objBorna():BornaClass{
	return this._objBorna;
}

public function set objWebServiceClass(_objWebServiceClass:WebServicesClass):void{
	this._objWebServiceClass = _objWebServiceClass;	
}

public function get objWebServiceClass():WebServicesClass{
	return this._objWebServiceClass;
}

public function set objUrlServices(_objUrlServices:UrlServices):void{
	this._objUrlServices = _objUrlServices;	
}

public function get objUrlServices():UrlServices{
	return this._objUrlServices;
}

private function initApp():void {
	this.objUrlServices = new UrlServices();
	this.objBorna = new BornaClass(this);
	
}





public function getUrlService(service:String, serviceType:String = null):String{
	serviceType = serviceType == null ? UrlServices.URL_SERVER_DATA_SERVICES : serviceType;
	
	switch (serviceType){
		case UrlServices.URL_SERVER_DATA_SERVICES:
			return this.objUrlServices.getUrlDataService(service);
		break;
		case UrlServices.URL_SERVER_WSAS:
			return this.objUrlServices.getUrlWsas(service);
		break;
		case UrlServices.URL_SERVER_ALFRESCO:
			return this.objUrlServices.getUrlAlfresco(service);
		break;
		case UrlServices.URL_SERVER_LOTUS:
			return this.objUrlServices.getUrlLotus(service);
		break;
		case UrlServices.URL_SERVER_ONLY_SERVICE:
			return this.objUrlServices.getUrlOnlyService(service);
		break;
		default:
			return null;
	}
}

public function sendWebServices(nombreWsdl:String, nombreOperacion:String, resultFunction:Function, parametros:Object = null, serviceType:String = null, requestTimeOut:int = 0):void{
	serviceType = serviceType == null ? WebServicesClass.DATA_SERVICES : serviceType;
	requestTimeOut = requestTimeOut == 0 ? WebServicesClass.DEFAULT_REQUEST_TIME_OUT : requestTimeOut;
	
	this.objWebServiceClass = new WebServicesClass();
	this.objWebServiceClass.sendWebServices(nombreWsdl, nombreOperacion, resultFunction, parametros, serviceType, requestTimeOut);
}

public function sendHTTPServices(nombreServicio:String, resultFunction:Function, parametros:Object = null, serviceType:String = null, requestTimeOut:int = 0, method:String = null):void{
	serviceType = serviceType == null ? WebServicesClass.DATA_SERVICES : serviceType;
	requestTimeOut = requestTimeOut == 0 ? WebServicesClass.DEFAULT_REQUEST_TIME_OUT : requestTimeOut;
	method = method == null ? method = WebServicesClass.POST : method = method;
	
	this.objWebServiceClass = new WebServicesClass();
	this.objWebServiceClass.sendHTTPService(nombreServicio, resultFunction, parametros, serviceType, requestTimeOut, method);
}

private function showPopUp(event:MouseEvent):void{
	PopUpUtils.objTextInput = TextInput(event.currentTarget);
	PopUpUtils.x = event.stageX;
	PopUpUtils.y = event.stageY;
	PopUpUtils.objTextInput.selectionBeginIndex = PopUpUtils.objTextInput.text.length;
	PopUpUtils.objTextInput.selectionEndIndex = PopUpUtils.objTextInput.text.length;
	PopUpUtils.showPopUpTeclado();
	
}
public function showPopUpAlfa():void{
//PopUpUtils.objTextInput = TextInput(event.currentTarget);
	//Application.application.canvasPrincipal.width;
	PopUpUtils.x =( (Application.application.canvasPrincipal.width - 900) / 2 )   ;
	PopUpUtils.y =( (Application.application.canvasPrincipal.height - 460) / 2 ) ;
	//PopUpUtils.objTextInput.selectionBeginIndex = PopUpUtils.objTextInput.text.length;
	//PopUpUtils.objTextInput.selectionEndIndex = PopUpUtils.objTextInput.text.length;
	PopUpUtils.showPopUpTecladoAlfa();
	//PopUpUtils.showPopUp(comTecladoAlfaNumerico);
	
}
public function showPopUpAgenda(objAgenda:Object):void{
//PopUpUtils.objTextInput = TextInput(event.currentTarget);
	//Application.application.canvasPrincipal.width;
	PopUpUtils.x =( (Application.application.canvasPrincipal.width - 900) / 2 )   ;
	PopUpUtils.y =( (Application.application.canvasPrincipal.height - 460) / 2 ) ;
	//PopUpUtils.objTextInput.selectionBeginIndex = PopUpUtils.objTextInput.text.length;
	//PopUpUtils.objTextInput.selectionEndIndex = PopUpUtils.objTextInput.text.length;
	PopUpUtils.showPopUp(objAgenda);
	//PopUpUtils.showPopUp(comTecladoAlfaNumerico);
	
}

private function validarTaller():void{
	if(Validar.validarCampos([vlRut])){
		this.objBorna.login();
	}
}

public function grillaPrincipal():void{
	this.objBorna.grillaPrincipal();
}

private function nextViewGrid():void{
	if(this.indexGrid + 2 == this.listaGrilla.length){
		this.btnNext.visible = false;
		//this.btnLast.visible = true;
	}
	
	this.btnLast.visible = true;
	
	this.indexGrid++;
	this.adgPrincipal.dataProvider = this.listaGrilla[this.indexGrid];
	setLabelValue();
}

private function lastViewGrid():void{
	if(this.indexGrid - 1 == 0){
		this.btnLast.visible = false;
		//this.btnNext.visible = true;
	}
	
	this.btnNext.visible = true;
	
	this.indexGrid--;
	this.adgPrincipal.dataProvider = this.listaGrilla[this.indexGrid];
	setLabelValue();
}

public function setLabelValue():void{
	this.lblStatus.text = (this.indexGrid + 1).toString() + "/" + this.listaGrilla.length;
}

private function showWait():void{
	var objComEspera:comWait = new comWait();
	objComEspera.Opcion = "Apagar";
	objComEspera.Texto = "Apagando el equipo, esta operación puede tardar alrededor de 1 minuto, espere por favor.";
	PopUpUtils.showPopUp(objComEspera);
}

private function showEsperaCache():void{
	var objComEspera:comWait = new comWait();
	objComEspera.Opcion = "LimpiaCache";
	objComEspera.Texto = "Limpiando Caché del navegador, esta operación puede tardar alrededor de 1 minuto, espere por favor.";
	PopUpUtils.showPopUp(objComEspera);
}



private function registraCodigo():void{

}

public function desencriptarBase64(deco:String):String{
	var benq:Base64Decoder = new Base64Decoder();
	var arrByte:ByteArray;
	benq.decode(deco);
	arrByte = benq.toByteArray();
	return(arrByte.toString());
}
public function encriptarBase64(ps:String):String{
	var benq:Base64Encoder = new Base64Encoder();
    benq.encode(ps);
    ps = benq.toString();
    return(ps);
}
public function loadModulo(mod:ModuleLoader, url:String):void {
	if(mod != null) {
		if(mod.url) {
			mod.unloadModule();
		}
	}
	mod.url = url;
	mod.loadModule();
}
public function closePopUp(obj:IFlexDisplayObject):void {
		PopUpManager.removePopUp(obj);
	}

public function actualizaAgenda():void {
		
		loadModulo(this.mlModAgenda, "Componentes/Agenda/modAgenda.swf");
	}
	



public function setClip():void{
}
public function limpiaCache():void{
	this.sendWebServices("Cache", "OpClean", cache);
}

public function cache(datosWS:ArrayCollection):void{
	if(datosWS[0] != null){
		if(datosWS[0].Clean == 1 ){
			showEsperaCache();
		}
	}		
}
	