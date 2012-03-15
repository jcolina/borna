/**
 * 
 * Clase para el manejo de peticiones HTTP y llamadas a Web Services
 * 
 * Fecha de creación: 02 - 08 - 2011
 * Autor: Max Moreno.
 * 
 * 
 **/

package WebServiceClass
{
	import Classes.UrlServices;
	
	import flash.xml.XMLDocument;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.managers.CursorManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
	import mx.rpc.soap.LoadEvent;
	import mx.rpc.soap.mxml.WebService;
	import mx.rpc.xml.SimpleXMLDecoder;
	import mx.utils.ArrayUtil;
	import mx.utils.ObjectUtil;
	
	public class WebServicesClass
	{
		/**
		 * 
		 * Definición de constantes 
		 *
		 * **/
		 
		public static const DATA_SERVICES:String = "DataServices";
		public static const MASHUP:String = "Mashup";
		public static const WSAS:String = "Wsas";
		public static const ALFRESCO:String = "Alfresco";
		public static const LOTUS:String = "Lotus";
		public static const DEFAULT_REQUEST_TIME_OUT:int = 180;
		public static const POST:String = "POST";
		public static const GET:String = "GET";
		
		public function sendWebServices(nombreWsdl:String, nombreOperacion:String, resultFunction:Function, parametros:Object, serviceType:String, requestTimeOut:int):void{
			try{
				var wsdl:String; //Almacena la WSDL
				var endpointURI:String; //Guarda la dirección del web services, por la configuración de los servidores esto queda con la IP interna que tienen
				var webService:WebService; //Objeto web service
				var operation:Object; //Objeto que ejecuta la operación del web service
				
				CursorManager.setBusyCursor(); //Seteo de reloj, ya que no muestra el reloj mientras carga la wsdl
				
				//Seteo de distintos endpoint		
				switch (serviceType) {
					case DATA_SERVICES: 
						wsdl = Application.application.getUrlService(nombreWsdl);
						//ws.endpointURI = getUrlService(nombreWsdl).replace("?wsdl","/"+nombreOperacion+"SOAP11Binding");
						endpointURI = Application.application.getUrlService(nombreWsdl).replace("?wsdl", Application.application.getUrlService("dataServicesEndPoint", UrlServices.URL_SERVER_ONLY_SERVICE));
					break;
					case MASHUP: 
						wsdl = Application.application.getUrlService(nombreWsdl, UrlServices.URL_SERVER_WSAS);
						//ws.endpointURI = getUrlService(nombreWsdl).replace("?wsdl","/"+nombreOperacion+"SOAP11Binding");
						endpointURI = Application.application.getUrlService(nombreWsdl, UrlServices.URL_SERVER_WSAS).replace("?wsdl", Application.application.getUrlService("mashupEndPoint", UrlServices.URL_SERVER_ONLY_SERVICE));
					break;
					case WSAS:
						/*
						var service:String = getOnlyService(nombreWsdl).replace("?wsdl", "");
						wsdl = getUrlServiceWsas(nombreWsdl);
						endpointURI = getUrlServiceWsas(nombreWsdl).replace("?wsdl", "") + "." + service + getUrlServer("wsasEndPoint");
						*/
						//endpointURI = getUrlServiceWsas(nombreWsdl).replace("?wsdl","." + nombreOperacion + getUrlServer("wsasEndPoint"));
						//ws.endpointURI = getUrlServiceWsas(nombreWsdl).replace("?wsdl","/"+nombreOperacion+"HttpsSoap11Endpoint");
					break;
					case LOTUS: 
						wsdl = Application.application.getUrlService(nombreWsdl, UrlServices.URL_SERVER_LOTUS); 
						endpointURI = Application.application.getUrlService(nombreWsdl, UrlServices.URL_SERVER_LOTUS);
					break;
				}
				
				webService = new WebService(); //Nueva instancia de Web Service
				webService.showBusyCursor = true; //Muestra el reloj de espera
				webService.requestTimeout = requestTimeOut; //Máximo tiempo de espera, 3 minutos
				webService.wsdl = wsdl; //Seteo de dirección de wsdl
				webService.endpointURI = endpointURI; //Seteo de dirección real del endpoint
				
				if(Application.application.getUrlService("transport", UrlServices.URL_SERVER_ONLY_SERVICE).toUpperCase() == "HTTPS"){
					webService.addHeader(Application.application.objWSHeaderSecurity.getWSHeader(Application.application.getUrlServer("UserName", UrlServices.URL_SERVER_ONLY_SERVICE), Application.application.getUrlServer("UserPass", UrlServices.URL_SERVER_ONLY_SERVICE)));
				}
				
				//Listener de fallo de carga de wsdl
				webService.addEventListener(FaultEvent.FAULT, function(event:FaultEvent):void{
					Alert.show("Se produjo un error en la llamada al servicio, error: " + event.fault.message, "Wsdl: " + wsdl);
					CursorManager.removeBusyCursor();
					//Alert.show(ObjectUtil.toString(event));
				});
				
				//Listener de carga de wsdl
				webService.addEventListener(LoadEvent.LOAD, function(event:LoadEvent):void{
					operation = webService[nombreOperacion]; //Seteo de la operación a ejecutar
					operation.resultFormat = "e4x"; //Formato de tipo de resultado de la respuesta
					operation.arguments = parametros; //Seteo de parametros a la operación
					operation.send(); //Envío de la operación
					
					//Listener de exito en ejecución de opereción
					operation.addEventListener(ResultEvent.RESULT, function(event:ResultEvent):void{
				    	var isCustom:Boolean = serviceType == LOTUS ? true : false;
				    	resultFunction(XMLToArray(event, isCustom));
				    	CursorManager.removeBusyCursor();
				    });
					//Listener de fallo de ejecución de opereción
				    operation.addEventListener(FaultEvent.FAULT, function(event:FaultEvent):void{
				    	Alert.show("Se produjo un error en la llamada al servicio, error: " + event.fault.message, "Operation: " + endpointURI);
				    	CursorManager.removeBusyCursor();
				    });
				});
					
				webService.loadWSDL(); //Carga de Wsdl
				
			}catch(e:Error){
				Alert.show("Problema al cargar WSDL" + e.message + " " + e.name, "Error");
				CursorManager.removeBusyCursor();
			}
		}
		
		public function sendHTTPService(nombreServicio:String, resultFunction:Function, parametros:Object, serviceType:String, requestTimeOut:int, method:String):void{
			var httpService:HTTPService; //Objeto httpService
			var url:String; //Url del servicio
			
			//Seteo de distintos servicios		
			switch (serviceType) {
				case UrlServices.URL_SERVER_ALFRESCO:
					url = Application.application.getUrlService(nombreServicio, UrlServices.URL_SERVER_ALFRESCO);
				break;
			}
			
			httpService = new HTTPService(); //Instancia de httpService
			httpService.method = method; //Metodo de llamada
			httpService.showBusyCursor  = true; //Muestra el reloj en el cursor
			httpService.requestTimeout = requestTimeOut; //Máximo de tiempo de espera en segundos
			httpService.url = url; //Dirección del servicio
			httpService.send(parametros); //Envío de petición HTTP, con los parametros especificados
			httpService.addEventListener(ResultEvent.RESULT, resultFunction);
			httpService.addEventListener(FaultEvent.FAULT,  function(event:FaultEvent):void{
				Alert.show("Se produjo un error en la llamada al servicio, error: " + event.fault.message, "Url: " + url);
			});
		}
					
		private function XMLToArray(event:ResultEvent, isCustom:Boolean = false):ArrayCollection{
			var resultList:ArrayCollection = null;
			try{
				if(event.result != null){
				    var nsRegEx:RegExp = new RegExp(" xmlns(?:.*?)?=\".*?\"", "gim");
				    var regNil:RegExp = new RegExp(" xsi(?:.*?)?=\".*?\"", "gim");
				    var resultXML:XMLDocument = new XMLDocument(String(event.result).replace(nsRegEx, "").replace(regNil, ""));
				    var decoder:SimpleXMLDecoder = new SimpleXMLDecoder();
				    var data:Object = decoder.decodeXML(resultXML);				    
				    var array:Array = isCustom ? ArrayUtil.toArray(data) : ArrayUtil.toArray(data.L.R);
				    resultList = new ArrayCollection(array);
				}
			}catch(e:Error){
				resultList = null;
			}
			return resultList;		    
		}
	}
}