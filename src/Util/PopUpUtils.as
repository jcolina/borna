package Util
{
	import Componentes.comTecladoAlfaNumerico;
	import Componentes.comTecladoNumerico;
	//import Componentes.modDetalleAgenda;
	
	import flash.display.DisplayObject;
	
	import mx.controls.Alert;
	import mx.controls.TextInput;
	import mx.core.Application;
	import mx.managers.PopUpManager;
	
	public class PopUpUtils
	{
		public static var objTextInput:TextInput;
		public static var displayObject:*;
		public static var x:int;
		public static var y:int;
		
		public static function showPopUpTeclado():void{
			if(displayObject == null){
				displayObject = PopUpManager.createPopUp(DisplayObject(Application.application), comTecladoNumerico);
			}
		}
		public static function showPopUpTecladoAlfa():void{
			if(displayObject == null){
				displayObject = PopUpManager.createPopUp(DisplayObject(Application.application), comTecladoAlfaNumerico);
				
			}
		}
		
		
		public static function closePopUpTeclado():void{
			PopUpManager.removePopUp(displayObject);
			displayObject = null;
			objTextInput = null;
		}
		
		public static function showPopUp(Obj:*, visibility:Boolean = true):void{
			try{
				PopUpManager.addPopUp(Obj, DisplayObject(Application.application), visibility);
				PopUpManager.centerPopUp(Obj);
			}catch(e:Error){
				Alert.show(e.message+" "+e.name);
			}
		}
		
			
	}
}