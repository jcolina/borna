package Componentes.Agenda
{
	import Componentes.comTecladoAlfaNumerico;
	
	import Notificacion.com.notifications.Notification;
	
	import Util.PopUpUtils;
	
	import WebServiceClass.WebServicesClass;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.events.CloseEvent;

	
	public class FinalizaEta
	{
		//private var mje:Label.t;
		public static var opcion:int;
		
		
		public var objComNotificar:comNotificar;
		public var objTecladoAlfaNum:comTecladoAlfaNumerico;
		public  var codigo:String="";
		
		public function FinalizaEta(objComNotificar:comNotificar)
		{
			
			this.objComNotificar = objComNotificar;
		}
		
		public function finalizarEtapa():void{
			
			if(codigo != ""){			
				confirmarIngreso();
			}
			else{
				Alert.show("Debe Ingresar Código");
			}			
		}
		
		public function confirmarIngreso():void
		{
			  Alert.buttonWidth = 200;
			  Alert.buttonHeight= 60;
			  Alert.noLabel = "Cancelar";
			  Alert.yesLabel = "Aceptar";
			  Alert.show("Desea Confirmar Ingreso?","Confirmar Ingreso",Alert.YES|Alert.NO,null,aceptar,null,Alert.NO);
		}
		
		public function aceptar(event:CloseEvent):void {
			if (event.detail==Alert.YES){
					finalizaSend2();

				}
			else if(event.detail==Alert.NO){					
					//objTecladoAlfaNum.closePopUp(
					PopUpUtils.closePopUpTeclado();
			}
		} 
		
			private function finalizaSend2():void{
			var parametros:Object = new Object();
			parametros.IDVehiculo = comNotificar.IdVehiculo;
			parametros.IDEtapa = comNotificar.idEtapa;
			parametros.CodTrabajador = codigo;
			//Alert.show(parametros.CodTrabajador);
			Application.application.sendWebServices("BornaFinalizaEtapa", "finalizarEtapa", finalizarEtapaResponse, parametros, WebServicesClass.MASHUP);
		}
		private function finalizarEtapaResponse(datosWS:ArrayCollection):void{			 
			if(datosWS[0].Etapa != 0){
				//No hubo un error en Email
				if(datosWS[0].Email != 0){
					//Si es distinto de 2, se envio ok
					if(datosWS[0].Email != 2){
						Notification.show("Email enviado a " + datosWS[0].Email, "Aviso", Notification.NOTIFICATION_EMAIL_ICON);
					}					
				}else{
					Notification.show("Ocurrio un error al enviar el email", "Email");
				}
				
				Notification.show("Etapa " + datosWS[0].Etapa + " finalizada correctamente", "Aviso");
				Application.application.txtPatente.text = "";
				Application.application.grillaPrincipal();
				PopUpUtils.closePopUpTeclado();
				Application.application.loadModulo(Application.application.mlModAgenda,"Componentes/Agenda/modAgenda.swf");

			}else{
				Notification.show("Ocurrio un error al finalizar la etapa", "Error");
			}
		}
		public function finalizarEtapa2():void{
			comTecladoAlfaNumerico.opcion = 1;
			Application.application.showPopUpAlfa();	
		}

	}
}